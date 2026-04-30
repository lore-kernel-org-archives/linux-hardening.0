Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B742849E
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557634; cv=pass; b=oZRvC+tnOIbMTx4++H03zXewULiWfEOUd4FAxbPf2tdDHOT3iEResDtMjHQqm+6UJ2pRGnSElWx7leddh8LkCtoPzsKVXr4Cd0cB+PAfaRvtGV403rHl2uJnabddXBvA3Ime16DOKk2LsASPzWXbuOfyOv0EqEeGm2dOKS42BwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557634; c=relaxed/simple;
	bh=q11TjLbVvV8woWQJHWB4Pgl2P7O1TL92s7zig4m0+0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnsFWsf7zuFDuuVGU+/0bb9runm/VNOUzK8yhK6LiAN2K6DaPZjtHMoUSbQyL00Vlyzhd0DMcBqdpg6qfYVoetGVlMtd7j9Gx9Szm4KyN8GJnqOjrr1W9vaPXW3BsYqEEIyNJJ9mLkRqyGM/Oe7i8WqOnd/mc5W1nU/7Rv3gRJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0tQbm9B; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0tQbm9B"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12713e56abdso778655c88.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 07:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777557631; cv=none;
        d=google.com; s=arc-20240605;
        b=V5JMe7DMIR5T6WAfEa5Jpee8VZUgzJGY7Tg2Bs6STe/XEHLEzR2YxRxLmvri5NcdNe
         sXJwummL5gH/EH2m6g4g5jjvdM30FGr0X48S3OhQvNrWYmC1KRNI9o1S2f+B80W6/nX+
         F2oQhFMxhSoP5YpbQXeGvbNS0eAvp0am7XCuSWatb5gzWZZ6sYOwtP1odO5bM9XKKjsg
         rAbE8RbMkvC2Pekmza4E49gYtThFyiTTu6Pv6B/5I0BBz0OJtK1Exu0DRVkMYT0DQ4yY
         4mbUjuc+6nIrHuR+UjJvp7szNwFtAeSLc8HuAIILypQ6WPP+dY36npx94thuGe7+10SE
         E9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FWbWmLupSF1aasSwvHeKUZ8NUkzaQhzFHcG2dLXCb2Y=;
        fh=Y669nVUa+Vi4EmIhOaaC8TfPufQqi8g7wY0WCmsBnvc=;
        b=jAp9KdFrK27Xg/83BMxy3lKoJvYLblM6Ka9CNaenGGuDN5p5/KBF9VCO5WwCwFvlIx
         xEPglVMOT5fa5NIBlMEagfjy9epJAYeAf82Mh2hf/Lq/kTSpGyjfNCrvsTTryIb2q1/O
         BBG+6JiIo9t3/AEFC4BBcR/Xgdct4lUzD8YmcmxGvbUpfiFYirxOHakIsK6FgoYNdxSB
         cEhkat8wt9Qz9lPQPoIcqJZXi37mMtm0mW8bEuuCMNibo5YIib6aXLUKtvJELKdnCkus
         SqSgDPfR3yzocmxmHzK1G7Z3EsI8BBBaHes9MRkczIBSOjTWDHff7ZJNTntCQqEdg/gm
         FbIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777557631; x=1778162431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FWbWmLupSF1aasSwvHeKUZ8NUkzaQhzFHcG2dLXCb2Y=;
        b=Q0tQbm9B1MIVXGz9UCnrF0SQJ95ozItGtVjiGTiS8LAyMInqzXq4sP6hMkajQVrJKT
         BABwlFUN7zcoeBZ8ig2iQsKaSXur2nZqzVvOqC7PsfHHFOs6PXGOvA58yS08/BiQaw72
         QTWtcGgaM5k/L1EZNg+35Uwv4G6VdMRQqU6u4QZPNZ2YxHcxETOmUMdOa/9qZDRuRdz9
         ayR/Johk0h9zNzequLgSDZ0W6NYfs0XxRLf8pcepoy3ZEslmYi3Q0FvwpvNundObdwUv
         BU6q/+Iv04qC28O+Hou04sHmoErIkDKWdYVFFCsklSrGdvuMqkCrD2I2wADF9JEWLRbg
         h0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777557631; x=1778162431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWbWmLupSF1aasSwvHeKUZ8NUkzaQhzFHcG2dLXCb2Y=;
        b=XknJy8ey9PkRdoAAXm3iKF86LUvhYjy5IevGXQHxTnekdkbHpOQP9AGR99YGVpTUMs
         XtPgoQGbbSeHT4hS4AePWnpMw89PRLV2XUenCA3p1ZSQ+ZuJ8BvSGg0+5Fdmq5LIlcWz
         tVsFajGtJR/y3+tiHFsUAZODeDdPFCKlvzkzPo5DaAhWliWttfHglYYIBPOrx3PsS4qU
         RDdz/OOoJa5uUdQLxzWu7vJ2b0eXiridVe2UOAEP54YhrkMP4Ql/PTWN4g9Vo0HCZOou
         8oq85TI3X5F99jBayJUGjol3tXMx80bux15TrQVcTEk3+hFbjZ+XXAPzPE/2fLdkre9F
         V4FQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AN3/uKbeeUQQ7SFZvMFN3VDUPcADDy/2L9CsbpqHVlU3SHDiCPaqTsOcxag0TB1yVcvEuA0VUgTQefx7iYtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrI8jNcDCngmlhZLuVXnRJj0Uw4/qT8mwfodz5fwaPs4omZpZs
	z9IPTcVdozE5BX6Fuip8EpgLKAj/RE7iLWYrAvoCatn1Xe1B5qY8ryFm7CEVop/YOWjozToVB6P
	w0ClTT8SayTC+Gnt8XplBOwKciz8Kw1XJXCznR8p7
X-Gm-Gg: AeBDieslA8aKWr5ztMCWUN1dLDbILEVkrJmKEQo/Y9+GI7fUv6f5n48lgC8AniCAsvG
	Nz5VvLRNPlpxgQyuboNzMRjtaupTMKYEL8WHMdi19YG0ZjtYfDLu+jyi9CYVCUPaVz/YKECvxaN
	8CRmD0TZq6wezvq9OotBLlHueGp6ZllqKkUxnIW/iWDdgFNqnuiW+v82hRyqKt21Av0nSm/M8Rd
	PRoHMUsZvbMegtouBJ+SWA0G4RO8vAagXbRYQQ9EJsDwPHb9W2VFCcvZulaz1VzTfN9tD9pgVS5
	88ip5hptsrlTFFnEH9oTHeIVKj3ov5sH01LFkTD/kPjc3fKt033wCjkVpBA=
X-Received: by 2002:a05:7022:92c:b0:129:1d25:f1da with SMTP id
 a92af1059eb24-12dec602250mr1294888c88.3.1777557630763; Thu, 30 Apr 2026
 07:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424132427.2703076-1-elver@google.com> <20260424132427.2703076-2-elver@google.com>
 <9c321184-9080-4d5c-bd1a-a16cd0bbaed3@kernel.org>
In-Reply-To: <9c321184-9080-4d5c-bd1a-a16cd0bbaed3@kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 30 Apr 2026 15:59:52 +0200
X-Gm-Features: AVHnY4L3BCY_keL_qhcVurJjgr2ukKogo3SaEXX5idcPkTjREyzfeKAeC-ucDp0
Message-ID: <CANpmjNN_=g31Eoa+w1NrFALfp1dDBi5oHEZdr_bA_48-tS2M=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] slab: fix kernel-docs for mm-api
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, 
	Hao Li <hao.li@linux.dev>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Apr 2026 at 15:40, Vlastimil Babka (SUSE) <vbabka@kernel.org> wrote:
>
> On 4/24/26 15:24, Marco Elver wrote:
> > The mm-api kernel-doc comments have been broken for a while, as many
> > documented symbols shifted from being direct function definitions to
> > macros wrapping _noprof implementations during the introduction of
> > allocation tagging (starting with commit 7bd230a26648 "mm/slab: enable
> > slab allocation tagging for kmalloc and friends").
> >
> > When the kernel-doc block remains above the internal implementation
> > function but uses the public API name, the documentation generator fails
> > to associate the documented symbol and generates warnings and fails to
> > emit the documentation.
> >
> > Fix this by:
> >
> > 1. Moving the kernel-doc comment blocks from slub.c to slab.h, placing
> >    them directly above the user-facing macros.
> >
> > 2. Converting the variadic macros for the documented APIs to use
> >    explicit arguments.
> >
> > No functional change intended.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> +Cc Jon
>
> I thought it was supposed to work because the kernel-doc scripts were at the
> time taught by commit 51a7bf0238c2 ("scripts/kernel-doc: drop "_noprof" on
> function prototypes") to handle _noprof. In the current form git grep finds:
>
> tools/lib/python/kdoc/kdoc_parser.py:        suffixes = [ '_noprof' ]
> tools/lib/python/kdoc/xforms_lists.py:        (KernRe("_noprof"), ""),
>
> Doesn't it work for you then?

Ah, I see. So it doesn't work anymore because we add the '_' prefix, too.

I guess the question is if we want to proliferate more kdoc parser
special cases, or just move the docs to the macros. The downside of
macros is that they lose the types in the displayed function
signature.

Preferences?
