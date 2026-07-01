Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A81374735;
	Wed,  1 Jul 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894679; cv=none; b=IYziv/ZvDenzJLOaEnsYOvGtz75sVdHS9NmbT4UeLWhqfUIEti/VCAQOIaBUY3XqSXAGKq1rgZl0eEwnCgEdvMKxA6vbigjmEkXgxI0DWVKjKpzW2neZC2VPw3wz6Fw+iKRhaNAgoiBieTOHKz23lQTMPpQwBfMPieDnfmproHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894679; c=relaxed/simple;
	bh=jeOJ12uisn2sjlJFwdaLeKFR2FzU4r0PplrkVt7Adek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tckm99+hT9G4gXzDeOOYe2e/H2Wi/RJlUxfLNp7RHtAWEAlbUY9JQWQk+RUXX6CqlVSYmWOcHfc8vLZAPlf6juzmN6UTn4e4VPwtr1ZGZCpn+gD4qYaEkv2/ajQbbPOH1lH3LR3B25my5rOV8jBlaNwRUvovDriCFpbCftQILtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JHAM2Cel; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JHAM2Cel"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RSAu5b3wdv4pEaqgx2siyAq2Ny91YmHLZ3XWjOa1s7E=; b=JHAM2CelxbHmDB56NFjTzk4T+W
	DEpFJEGBLrSt4TUVDIHWmJKMS8DMgLVJphE/eJrHrOBfNbjIbYWC3Ekb0XmyboMFfaW39avBBkrg1
	xeVda5iUxiSiYgzJkFlFr+G4vQDCj75TcM6xJLj2DUOouYPFFAPHux0uW4fIcdVHtA+PnofOc+BZq
	I/WOrhosWFgSo/P4ClObHxWkPw4fSvgyJcot2V8G28jShQT+3+TvxDxlWj3B+d5rmWkMzopnx+R7q
	FzM2WbuMPkPSQMYFRCqMivX+Nx5JTFhr9fKFrw55ClO4QlDhXd63PB28E4PEqK3J6ByUxKdYf+/eY
	eOw2CsEA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1weqLd-00000002VjW-3Dqd;
	Wed, 01 Jul 2026 08:31:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7C23F30035C; Wed, 01 Jul 2026 10:31:08 +0200 (CEST)
Date: Wed, 1 Jul 2026 10:31:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Xiang Mei <xmei5@asu.edu>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hardening@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
	Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <20260701083108.GD751831@noisy.programming.kicks-ass.net>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <20260701072747.GN48970@noisy.programming.kicks-ass.net>
 <20260701074834.GI49529@noisy.programming.kicks-ass.net>
 <8730D74D-6395-4FF4-B9F9-06AFABBF8CDE@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8730D74D-6395-4FF4-B9F9-06AFABBF8CDE@zytor.com>

On Wed, Jul 01, 2026 at 12:58:12AM -0700, H. Peter Anvin wrote:
> On July 1, 2026 12:48:34 AM PDT, Peter Zijlstra <peterz@infradead.org> wrote:
> >On Wed, Jul 01, 2026 at 09:27:47AM +0200, Peter Zijlstra wrote:
> >> On Mon, Jun 29, 2026 at 03:29:50PM -0700, Dave Hansen wrote:
> >> 
> >> > But, really, if ENTER is so evil and nobody uses it, shouldn't we just
> >> > have an MSR bit somewhere to tell the CPU to #UD for it rather than
> >> > playing these stack games?
> >> 
> >> For supervisor mode only, I suppose. We can't ever get rid of userspace
> >> ENTER because legacy I suppose. But we can make sure the kernel is
> >> clean.
> >> 
> >> So yeah, having a knob to make supervisor-ENTER trap would be useful I
> >> suppose.
> >
> >x86_64-defconfig builds clean with the below :-)
> >
> >
> >diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> >index 1b387d5a195b..9e53db863203 100644
> >--- a/tools/objtool/arch/x86/decode.c
> >+++ b/tools/objtool/arch/x86/decode.c
> >@@ -642,6 +642,10 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
> > 
> > 		break;
> > 
> >+	case 0xc8:
> >+		WARN("ENTER instruction at %s:%lx", sec->name, offset);
> >+		break;
> >+
> > 	case 0xc9:
> > 		/*
> > 		 * leave
> 
> The problem is that it being a single byte long it can appear in the middle of another instruction. 

I understand; this was in response to Dave's suggestion to make
(supervisor) ENTER #UD, in which case we'd have to ensure no legit
ENTERs exist.
