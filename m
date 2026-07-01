Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA843BBFD0;
	Wed,  1 Jul 2026 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892126; cv=none; b=Kcc0IwgQy+/f1B/Jp6o2GrCze82TOdQAhfSWQsdJ4HSHaWc0EO6lyw8CysKLMCn/eP0cf/lHcRrun4I6yqSn4Lb2jPLFi0AlRVDs2BEycF0cOuDG6RtK2XWTLf6Eeo/MrZxA0Nj7TPyT9bdgfDu+tNtf6yagVoZEIMZI7Dk5kbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892126; c=relaxed/simple;
	bh=tHj9WTq9YeQ/6JC9x3UrQbmww4EjgHRNFBuXkTxVkdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBVNh41F4pr2lNc7zozelRRQfOwlf7E0uHgOOJuVzwKmG25RkCmgLec6iBM5SyT5lU87XQGMNs3JWOC4nyEYW2VuE5kimsBQQkyzNhJSQohHiDS0XcaMwRatj2axmEqpwjnChU4aae86gZgP586Nv3+g5M1+0C7dq/cyMkxmM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nftf9ryp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nftf9ryp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fFqD1yFrJpRU/qiUB0Dl/TygipY0PABdXOWIH6V4FzI=; b=Nftf9rypiRDLiFj26fic/t2RLo
	7mI8iXJIbf6HKEdECtW6gsKZ/5rVZ3m0tJFpeFsRBbLL/MOhXqt/SxeiyGixqnjMQ5pE+M+iJEwFh
	Q/wLcZpN1MdXNrRE5rV07JLScCAMDtVuSMYlTfLILP6qfjcL/P1JILbUXZ8FVsXrhvXpgDun6VQyP
	wKySgBEzT3JeBqvIj+m0vnKwMA5RMWVbCVvhTIi4wVvSqGpvVpUAY3XAJnqVwIhssb6MnZt8xodEn
	65CuXwpXrIqIc+D0WJtvBT4ylp40Q8L45IMpP9kwGdEAUum0STvOBycwfAj2IqsH/UYhWffoMbaGD
	cKkQ+chQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wepgR-00000006FQY-0uqR;
	Wed, 01 Jul 2026 07:48:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFE0330035C; Wed, 01 Jul 2026 09:48:34 +0200 (CEST)
Date: Wed, 1 Jul 2026 09:48:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Xiang Mei <xmei5@asu.edu>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hardening@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
	Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <20260701074834.GI49529@noisy.programming.kicks-ass.net>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <20260701072747.GN48970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701072747.GN48970@noisy.programming.kicks-ass.net>

On Wed, Jul 01, 2026 at 09:27:47AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 29, 2026 at 03:29:50PM -0700, Dave Hansen wrote:
> 
> > But, really, if ENTER is so evil and nobody uses it, shouldn't we just
> > have an MSR bit somewhere to tell the CPU to #UD for it rather than
> > playing these stack games?
> 
> For supervisor mode only, I suppose. We can't ever get rid of userspace
> ENTER because legacy I suppose. But we can make sure the kernel is
> clean.
> 
> So yeah, having a knob to make supervisor-ENTER trap would be useful I
> suppose.

x86_64-defconfig builds clean with the below :-)


diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 1b387d5a195b..9e53db863203 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -642,6 +642,10 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 		break;
 
+	case 0xc8:
+		WARN("ENTER instruction at %s:%lx", sec->name, offset);
+		break;
+
 	case 0xc9:
 		/*
 		 * leave
