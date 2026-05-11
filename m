Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C6F3CFF5E
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517316; cv=pass; b=Njip8bTIobRshqfSarfkBlBlXImu5TefaKtELimlicNx99Ho230WMqYxVt9DLIv+5q+WQ5KXjH9wxWXSJVIqOtnUa3RgIjmySeJUw6m+ZnPKiZ8wT4seg5P5AcauvyS1WKSPPGQn30VAdQ95CTEMum+q2EFrhDmTMSsVhtnrA+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517316; c=relaxed/simple;
	bh=4S7C02MIUqtzmropOUva8L19yYp6EZ1lPURTmBTWjnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuXdItVe9XT7RXFC+wr+bXl0SzScmGTvV5x2RDwFSdt1h1zCZ/6k5N2aZoCZe+vEFWGrJmIp2jpQOPasvmU14JWXvn9eOVCLbd5ghhnAHuhJTf3II1fACWMje/adaTIiW/kFqLgAworYGa/AdmOa+HFEWxWDdC6/VoIQWNdfebs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZL6FK5y; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZL6FK5y"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1330d6bb78dso921678c88.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 09:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778517314; cv=none;
        d=google.com; s=arc-20240605;
        b=W3+lSXyIaZ71AgxarehxGDDDcU1netdoYSsw6bR0Md4oC8IoSQMTU1zzVIrQhwEZNx
         0VYG5ejq3HwpYSDFZbytje9/lsvF6MrPGrphkcxlmSp+yyie2plh/co1Es3gicoXbqHQ
         38hoADEvfL5IFVieOvfV1dXM8zlJUL8YCYCZfZ3m4HQ14ZppEgzQ2rkXg1eXy8jKZK9x
         I2KZSE8iIjp3kMIpbkAPlovujmlflfntdk8+3kRGndLsxyoI2qvMhYQhk2VJiGIGfq2/
         mIhM8+YJneCvGPuahEQjNo1dWCkkry/VL/S0m9nM9pXP5t71A2UEjLYdhNq+oXXm6050
         ymXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1buMrZnL5eF5p/xBeXqRPyloQLFILIM6omdsc97ttuw=;
        fh=3SWPus0Yw5fO4z38gs640DI4+LpagaqSHSo5J2Z0urk=;
        b=I0ZZCAfdI98logxhBPFBtQYaASEezhO5G0IrgvssHELzyFHOim8rZwVrf5L5oFhiFw
         gFx7rnRRD5qsN2t371g8fngVJr+NcUA+IFsHCPuaQA/zqAMNMSipCigY5IgIfmwP3GK9
         6cr42ySvD+UMV71Cr8fvVRoTUEFTydin6INqhwFJFyTQ+9I90YY+6dYt7y/OEL+OGB0v
         9wjjbRtfmoPRga0CmzXpISscMCnUwcCSIkOkZHy54FijIUGz/NP7WPHvvkYf0m2u2K/M
         vE0yTsS3BCRBf+uxvfAAj/s/tGXW6nISYSPScYB5FBiq0EaDt1prlNFR0Bhq+/YTMQ7y
         9nHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778517314; x=1779122114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1buMrZnL5eF5p/xBeXqRPyloQLFILIM6omdsc97ttuw=;
        b=qZL6FK5yiHGU1UYpFox73RIlI3Bp+cacpR16tSKhsLmdbEUwqTWF7PkSPDxv9OwoXw
         /UEi0zPK06a1LzR9ZZ23m9YOZ16GidMugm7oobi2d1+EHh85B+fY1RjRKsM45paKtC5A
         A0T5usgqM4rS59r5k+ecCruSenojaTYEB+TqcS+tuMGFQ6F045Lb93YOeJLRFcUaZHa1
         wFEL0ijZ2/+3oP8sE7HixjnJnUXr4tojrllQXnb121sfLEIGfbocVhKNpYULSqPJweJS
         HHQYNl+HkiAVO2dmBQHsLzJ7zPP4hRHptHYGuke86yPe5KMVcK4n+QlBsEmDzuSBLcW0
         ZBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517314; x=1779122114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1buMrZnL5eF5p/xBeXqRPyloQLFILIM6omdsc97ttuw=;
        b=lOFCrZqkRjf8hd8f7IW14SEtS6SDBiU6TntFNpXECwwFbWJKi3wfaM7Iy+c/l/DB0q
         yZh8QEzIJjndcO9Sr3sb+cBAxwiDImBrv7k+ZffjgkQyHu1UzSPRHLQiNYAxZ3LIN6Oq
         OSEJm1MatS/EZ7fK8HueDNBKIsXyX+FgBwDNjaRiJEhzIOXYupVQ3GCtEPL61myTvApX
         jsMATBgw/q2/kdl+9/yRiTCf9q7V7+gADuPFBorAbFiDpoAVN06CajgI4nbZkrOVcnMb
         TtrxRF7WabWgHCX+UF7PD19vZFlyXW5VLHvUJVmaGLEQn/HMC/uvZDECIShe45SgOYlN
         I/Pg==
X-Forwarded-Encrypted: i=1; AFNElJ+umCObW8n4Vm3vYnzXHVZJiu0pqW/zl3mnkHhTaSyp0tL69P75VQcTL2plXP3NiDK7uBgrekjSnMSMNE1U2Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dd41NkhuQ1dxSOLDVCH1BrTJgr5O+Urzte20uBr+dSTKmrFx
	XrLu8nxtssuI1L8wRh7Hj6o4SgwUfzL2+/Uc9u79Za+lcFGPiCLB+PPiSijo3G7cDKYpygi2DgE
	dZSbW1+V0uuPKN5bp2t5+8PqnjDYgbg0VichZuyJp
X-Gm-Gg: Acq92OGTzhYMhBxZKchafST3CBNXyZn1YLlR3+bQls46FQZ3W7LTGX+VGp3n+YB/dxl
	NsLnMrfgcymLiTLjgStouoNpEL5cObhGbcWMIrVumj2iM1hRixI8DEYLCPvsXFYdJRBMX3KmKA0
	C6Q4+pdYm7ZmKqMAY0pu+XCmdWX/N0PVfamFjmbVQbpZ8wAQJTr9DHIGuROQ/6FPB2dDukVV0C3
	7aOl7hUP9aToWC7ogJ7D1mjGzKcm5S77+ZZdLXacqzE7niOpN8XYKDOa5sCfIxZUJgZYUxTshAc
	v8KWkASDnldy8mVUAx1P4l4I8gOLFfY6Ha9V4OEl7TAuGNTSe/x7AhJwqTqH
X-Received: by 2002:a05:7022:699d:b0:133:39a6:2b8b with SMTP id
 a92af1059eb24-13339a62ddamr337498c88.44.1778517313279; Mon, 11 May 2026
 09:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424132427.2703076-1-elver@google.com> <20260424132427.2703076-2-elver@google.com>
 <9c321184-9080-4d5c-bd1a-a16cd0bbaed3@kernel.org> <CANpmjNN_=g31Eoa+w1NrFALfp1dDBi5oHEZdr_bA_48-tS2M=Q@mail.gmail.com>
 <afi0nQ84k1oz5RyH@elver.google.com> <871pfiw343.fsf@trenco.lwn.net>
In-Reply-To: <871pfiw343.fsf@trenco.lwn.net>
From: Marco Elver <elver@google.com>
Date: Mon, 11 May 2026 18:34:36 +0200
X-Gm-Features: AVHnY4JXza1HWD1Ghv5ACGmGvnp1cOeRA6XD-S98uX5BfJA-pjXWKAfvxk-IzaE
Message-ID: <CANpmjNML=pbnv7QLf8Qi4wY2nDCk6oOw2T_Vs-MfMwWh=0m5Ag@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] slab: fix kernel-docs for mm-api
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
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

On Mon, 11 May 2026 at 14:19, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > How about the below, i.e. adding type decls that only the kernel-doc
> > parser sees? One complication is also DECL_KMALLOC_PARAMS, and adding
> > kernel-doc parser hacks for that looks pretty awful, so this is a lot
> > cleaner.
>
> I'm going to be a while catching up with things, so this is just a first
> take.  I strongly suspect that the people who object so strongly to
> documentation markup in general would be less than fully thrilled by the
> addition of this kind of workaround.  I'd like to ponder a bit and see
> if I can some up with something better...but again, it won't happen
> right away.

Thanks, Jon.

The technical debt (hacks) that would accumulate in the kernel-doc
parser just for accommodating slab.h might be quite high; slab.h is
rather special, so the "#if 0" solution might be justified. Then
again, if there's a reasonable kernel-doc parser solution, that also
helps in other places, I won't object.

I tested the "#if 0" version and it works as expected. So to move
forward, we could consider it in the short term, and in the longer
term, see what new powers the kernel-doc parser can provide.
