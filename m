Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5A158D78;
	Fri, 31 May 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174410; cv=none; b=bIiiIhgcSD2zsFxW0/Wl7cMBv+8lXthxBHFoGi19gLd5WZfwDYqlDjoXvJ+QMHM7XSH1i6f4rPcRk2zoGVGg09OQgb1IaeB6RBxx+OaNYkDIjiTxoP977WaCFjemTyFcVNWA0fhUVPfHMrGlgUegwDezhJeK0/3OBAV60Xfm3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174410; c=relaxed/simple;
	bh=A0VCX7boZ90t1G554mzzcAAyW5pi+5OsLc8t8Pv/41s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X++TAZESsdA5tv4NXBziXqmMN1OhmJZ/chrn3XhDSMz07hK1RtI4JJVgcFMw0X59UrBG8yCWKhII9bPZETPN7RLiRWbnz8Ia2PoeqoP8AmWu4DagJvblSKOSEGMF827rB/TbaUhqt4EgLDQe0WlFTRv3fBSuH9g+8EM1OYMkwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chF5K+Jg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chF5K+Jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4DFC116B1;
	Fri, 31 May 2024 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174409;
	bh=A0VCX7boZ90t1G554mzzcAAyW5pi+5OsLc8t8Pv/41s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chF5K+JgyD3w37TtdSB2AESkw6uLvl4AkHW/MlWX0bRq5Tpu2rdXGgvVUvPPSTHBp
	 YkVK5HhdThUPDkgipZfcMGtuvAzRQAjgwyUfBuV+svm1CycIYnwp9lfOBxAyVw0S/t
	 MYkFc+X2HFtxR/r9udAjhGBVUcUAhpfxmRzM8zHwW5sV6M+D0Z5wSyjNTkA5yKM3yr
	 Y+8JLgftyLFJQvyvY4ZveBO9SONjQsWUP3Sqt3WAfnHLKvCfkR9qezooLXMX4CJNUc
	 NJew6a6JXCQQ1CsfxMsZ1s29BspclaZhxA9N+VhmdM2Nluk+3riwXZhZioQUUxIfA/
	 j8PAepjQVMtVA==
Date: Fri, 31 May 2024 09:53:28 -0700
From: Kees Cook <kees@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Message-ID: <202405310951.56D9BD5C41@keescook>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>

On Thu, May 30, 2024 at 06:46:39PM +0200, Borislav Petkov wrote:
> On May 30, 2024 6:23:36 PM GMT+02:00, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> >On 5/30/2024 8:42 AM, Nikolay Borisov wrote:
> >> 
> >> 
> >> On 29.05.24 г. 21:09 ч., Jeff Johnson wrote:
> >>> As discussed in [1] add a prototype for __fortify_panic() to fix the
> >>> 'make W=1 C=1' warning:
> >>>
> >>> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?
> >> 
> >> Actually doesn't it make sense to have this defined under ../string.h ? 
> >> Actually given that we don't have any string fortification under the 
> >> boot/  why have the fortify _* functions at all ?
> >
> >I'll let Kees answer these questions since I just took guidance from him :)
> 
> The more important question is how does the decompressor build even know of this symbol? And then make it forget it again instead of adding silly prototypes...

Under CONFIG_FORTIFY_SOURCE, the boot code *does* still uses
fortify-string.h. It lets us both catch mistakes we can discover at
compile and will catch egregious runtime mistakes, though the reporting
is much simpler in the boot code.

-- 
Kees Cook
