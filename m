Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD4209F5A
	for <linux-hardening@vger.kernel.org>; Wed, 10 Dec 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765328430; cv=none; b=a+5epvDYnnxW1aV7K7aRjJTAeJkSLc4urB9Be/7xmgkBJXOlo3ISqX+enTMM9h23KPP/cz1S86nV/D3MJ4xK2EACWX/QrqT2K5P/qpC4nYK79temeG9mPBr2aC/KdTl6mXJFDm3G3CLKphXDssWRk9uoBISHPcezZwqHE3Z6vz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765328430; c=relaxed/simple;
	bh=3ajHi0yHPov0SKg4O4bcCBy0K1fDiVaVSenJjs4a1bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNZqIlvnV6S/1di2KZ1RNUKmVdERDiqNysuXn82hUx1a1VybOGQqGNTH5kqvCQlTKY+F7h7hP8lDbbIZfcPNhaOvelbt64Uu7TYCimsj7MyPEANmnUlg39/qCax3zBfWJWz4siaaRKqJ3IIFV+3wkBEs7HIgmXSSi76w1hjXZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgKyzH2s; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgKyzH2s"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29e0753e5d8so53005ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Dec 2025 17:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765328428; x=1765933228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=691lAnJLGf8S4+TJC63j4SAsoo3YOyh4dWuPiM7IB1Y=;
        b=kgKyzH2swSxVXBMaeFB7gJNTGVVgRjudOLs5hyYnbuQNDZYS3DQU5oDVuypi7nzWg9
         UoL+4TIYLG/v7OPda7a+tAnkkmJ99+fzXqQD+m3yO1/Ha/p3V85KH7NdXFrAOiyo0m3i
         u2tNWXzPMA9rX/jwPHk9jlYKQap0e0xHDMIAE/jkQzpulvbUSO4e/mwHjOtPwzVBIcue
         vedJDref403j9C210J/b2na+jJ5GArAgTkXCoCx1P+NPuRnGGOjE/YFnvoh5FldRbm9R
         FNEMj5Obb9gRP0A692VrbA8jYKtIC3y5ccADwF5EWJa8Zzy/eIoj2kXZU+PgZsDB7WqZ
         CBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765328428; x=1765933228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=691lAnJLGf8S4+TJC63j4SAsoo3YOyh4dWuPiM7IB1Y=;
        b=cFkuUVr2zs4D7vS7mUPFdwxzRVxAAnWX+k1uyBFnl68Jsum7eZMxp3cnqJnEW4yMgX
         dpISXthSFlN9V/h/L2FM5gztVJomtg8lKFR0xBvVGdosySgAjZGl6hEK36V2wF/mHswF
         NNMs7919NfD9rsCVkZsx9yhApxA9Ttyr+Er6ciFioCv9MkHjRiEZJX++3IGKnJ6XswhH
         ikPipXI8V1VugEDXejwq1vFUiHiZNuPeR7Ypr8CG50hT8/gJqllI3D7aM/SWb7DerREM
         CNWwQhJurt81lwO4mH9dVxuk9X25DZLGGhNi+OlK022W+qFa2EiJyaTz7mrAj9vgiamS
         G2xg==
X-Forwarded-Encrypted: i=1; AJvYcCXruBwz9UjDW3PW0/gwJpwEhvnmBMND2RTNaAx13cL7xaJHezUaalNINMhpUdOO9H1po34CYd6Z/rNta7mxH8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpkjrZutvSiuPbAI4QAyeElfYIeHo/jxBGD5Sq2Lk1MXSjigGA
	TiGaBVA9ln0nAC1jun1TyWeSyAqrch6y8/Rw9DGMRR9B7K27WOiD+mlLopbha2ZK/g==
X-Gm-Gg: AY/fxX7QyVGOw98yxOryJ26hQvG/bq7I2gKdegG9bJjCXgUXMVelWrHmwVETEpPfehu
	b4XgT4KIGoywBiuN94kD8UfD1VjXip2iFPVXmCzVw1QLHbKuZTPiHcYS+3XtVKKz8dY636D0/i/
	W7O75uVut1ULu0X69BjGtoZDshX10UVUC3BpLx7MczJjQ3iGYGjcTWoNJwTAx2ttFWNRdYaRhq/
	uQ1d2VQYF+CqpuzWCh5Kt+7CXSsVWen2t+Rl0PHkEeSh3VpNXkew/WGxKqDNbvHshYrPvt139RO
	00PuCO+UpeD8pbXPf2eDTTfIoxNW+sM4iYqFoF7Ah0sMfCJpQhIqTESjBRpD0Iqte4DgXxtFSdp
	s35GPhh3d+59A0i8Gs9Nbo6g5UAdIr1f1z0CVWviGJfb2LrQhFSdiACtRjUQW66GuE38xQKHM89
	SER0P6RhBDuSfupW01sZhg6lc6Kk5WMdZnxMu0EaST1MMGPJqhC1O0HO8=
X-Google-Smtp-Source: AGHT+IHwazsr/LFDDUVLr6lpCN1u73yiv9zYWPNsYlgfC/SF2jnbI472ByJ0qhQLxPF8fI22SQq4QA==
X-Received: by 2002:a17:902:d4c2:b0:295:1351:f63e with SMTP id d9443c01a7336-29ebf8ce459mr1596665ad.10.1765328427004;
        Tue, 09 Dec 2025 17:00:27 -0800 (PST)
Received: from google.com (99.181.125.34.bc.googleusercontent.com. [34.125.181.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a07213b6sm17205315b3a.26.2025.12.09.17.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 17:00:26 -0800 (PST)
Date: Wed, 10 Dec 2025 01:00:20 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <20251210010020.GA2522829@google.com>
References: <20251008033844.work.801-kees@kernel.org>
 <20251008035938.838263-3-kees@kernel.org>
 <aTc9s210am0YqMV4@agluck-desk3>
 <20251209001139.GA7982@quark>
 <d3dd8fc8-ab46-4cf1-87a9-0324685ba2e0@kernel.org>
 <SJ1PR11MB6083C6D97484ED4E4710268EFCA3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aThSGiKwJRYOB6kx@agluck-desk3>
 <aThqcq0iGge1pQCr@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aThqcq0iGge1pQCr@agluck-desk3>

On Tue, Dec 09, 2025 at 10:29:06AM -0800, Luck, Tony wrote:
> On Tue, Dec 09, 2025 at 08:45:14AM -0800, Luck, Tony wrote:
> > On Tue, Dec 09, 2025 at 04:20:06PM +0000, Luck, Tony wrote:
> > > >> Likewise, I just got the following kernel test robot report sent to me,
> > > >> where it's warning about MODULE_LICENSE("GPL"):
> > > >> https://lore.kernel.org/all/202512090359.7BkUaiC9-lkp@intel.com/
> > > >
> > > > Can you both confirm which version of sparse are you using?
> > > >
> > > > My understanding was that this patch fixed that problem:
> > > > >https://lore.kernel.org/linux-sparse/CACePvbVG2KrGQq4cNKV=wbO5h=jp3M0RO1SdfX8kV4OukjPG8A@mail.gmail.com/T/#mf838b3e2e3245d88c30a801ea7473d5a5c0eb121
> > > 
> > > > The patch is already merged into the sparse tree, and I was not able to
> > > > reproduce the issue.
> > > 
> > > I pulled the latest sparse source and re-checked before reporting. Top commit I have is the one you mention:
> > > 
> > > fbdde3127b83 ("builtin: implement __builtin_strlen() for constants")
> > > 
> > > I'm building latest Linus tree from the current merge window (well latest as-of yesterday):
> > > 
> > > c2f2b01b74be ("Merge tag 'i3c/for-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux")
> > 
> > I added a debug trace to the new expand_strlen() function added to
> > sparse. It is being called and doing the right thing. My trace says:
> > 
> > 	len(GPL) = 3
> 
> Simple test case:
> 
> $ cat -n s.c
>      1
>      2  _Static_assert(sizeof("GPL") - 1 == 3, "sizeof");
>      3
>      4  _Static_assert(__builtin_strlen("GPL") == 3, "strlen");
> 
> $ sparse s.c
> s.c:4:40: error: bad integer constant expression
> s.c:4:40: error: static assertion failed: "strlen"
> 
> So the "sizeof" bit is OK. But the __builtin_strlen() isn't.

This looks like a bug in Sparse. The CEF_ICE flag isn't propagated to
the comparison expression, which it presumably should be when both
sides are integer constant expressions.

I'm not really familiar enough with Sparse to know whether this is the
correct place to handle this case, but this quick hack fixes the issue
for me:

diff --git a/expand.c b/expand.c
index f14e7181..71221d35 100644
--- a/expand.c
+++ b/expand.c
@@ -535,6 +535,8 @@ static int expand_compare(struct expression *expr)
 			expr->taint = 0;
 			return 0;
 		}
+		if (left->flags & CEF_ICE && right->flags & CEF_ICE)
+			expr->flags |= CEF_SET_ICE;
 		if (simplify_cmp_binop(expr, left->ctype))
 			return 0;
 		if (simplify_float_cmp(expr, left->ctype))

Sami
