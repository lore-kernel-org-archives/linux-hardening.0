Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D13FE653
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968946; cv=none; b=AZV3T/YxAOvdmm6kswIZXBrNUZO/fvOR+Wfbo3dqH479Qc/ficSjZBPkRpeSJi/rBl1JZf62DuOf8mTd+pKymkQCHukO2PZiB1qk5MgypzDIKMsw4yxrEyN1RlfGlXpmSONSOlgj4MOjTEeK4ajy+XdM+u7ZtmDou15aSwhTlOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968946; c=relaxed/simple;
	bh=bUkLek+dHDn/UBKanQCUz/l1OEBhgtZsGy6Gp1DMqxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmDznc4mg8ESRHlQPhW/k7p0P49c4V9EGWg9fM1zwsMMd1lV2dF2fDgAgjEfwJX746K1OFeuUJFDFtINq/oQDO4leM1QyCJhyqF6SO33T0q4TMnjqZbLnczMhuS24obisW92s1UbwulEdCP5O0D8sSwv1gKfosrlcJDqDwV8S3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqRTeQ6w; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqRTeQ6w"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfd832155so1538744f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774968943; x=1775573743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqHHDUqIclluzk0swGJGqBm0kNqls0rOfMS16PbzCSc=;
        b=RqRTeQ6w+2NW40J51B2iiJkTHZiiI0gLtNtordbxSnEWgyo9ptYZ2fd5JQHc3f0gD2
         RpNdMb4Sk4m92T8HoN6dp3mKnkVyk5K6aas2FB+l75ssEHuPh248XXQBX28tV1zxysOY
         jn3OPK2qFrh3b7FFSRnJHsFv78MSew9EoiX8RWUOe4Ofu1PnleDiyTUcX+Hz3yDwDT9t
         npnXwWRnxSOssbYn/ndr/xhmlG7p2RSyHI/84PlEG6JRAfvODzok0m7uvB7WWuIxB+zq
         GsuPaPl1lUJ/pKXHKVi3VNTRMSu8AiyO+EUGzfvhIwM8g5p3DMC+nahJHaOoyQ0eLle0
         ygxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774968943; x=1775573743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqHHDUqIclluzk0swGJGqBm0kNqls0rOfMS16PbzCSc=;
        b=K1SsgC3PU/cvt8O63R5/NRDiWYATKD0wdTXgg0C7PjhHEBlDaUDBzhcLwUCTIN5ja5
         mTQ9EovhG2Dbtkf5cYfMUuJ38+hcgXvwqsEsFjhOEpSRpT6aCTPQoZhSurzyXUEmDwaq
         y27Uj83nZQOujAg0ym2Y/XrKhab+xjCTG+5wLJDkobO44/qfiCHodtKL9/Y3bzBgeTHq
         Ar9UzdpSheIaPPDzdmwr7IZtiJC+M/KJee9xKkLO9+WSG0qjI8lLzjSoCz8LvNeycHTZ
         TgOO6mcZjLUxz3cu2t9axJCHFDGUrmggCqdv93LT329b7vgpVQ/Ms+8z0B+PhGmcd2uO
         RruQ==
X-Gm-Message-State: AOJu0YxB2hjTSL5B+017GnRQ63S3hTFPkuW5pecwfW2YzOWEG3YOVp4m
	93QVImrcMP61k4diTjV7HFvnVULFh3y2K8NSOIMAi56kUTBWtAejstZm
X-Gm-Gg: ATEYQzxGHc0YmgPUdxThx8mBIm38sEHIRoRAarWCOxbMjXm8XAYIhJ+jhdYj9NBUNzA
	84KSMpeycA22aroq2ZO5/IBQZtUshMz6kQGNAVpk0TQ5VKPgFWpog/8b2OchoSZzKUtqFwuD5MX
	SS+2h2NRBwTto9fOg/rVUYDq3LTaC4n1F12gxEC8JMe9QES2G4dZLt8pdyFX1bbtH/6Mqmezdlc
	JPcUXCw11JoU3RZHhtw33iNOvbyz4MwP9QSDtqpdwGv6gflPEur4aW7fOo2X+QIFbA1ifiVwofc
	PvnJZmoeqPrU5EvYvImrEU8ftZLT0QJnDjHhJX21GQKgvm7c5Kx5DHUaRr3NQ82whzlrVojw7zc
	ogOrG0x59vRGqKBy13HYJ+x+SkirPNy9IPR85/fKYCNM6HD/vIb52FUIW/y+8zn0iN0+jTn+Njk
	VKb2K5z+r9Ap6noYl0VvU/pwHpap5fK3hAGrBz78mgCLyvUKHVpMaKaSxhEua91a1qVhpbYDg=
X-Received: by 2002:a5d:5d88:0:b0:43a:4de:fdc2 with SMTP id ffacd0b85a97d-43b9e9e89a4mr28439291f8f.13.1774968943148;
        Tue, 31 Mar 2026 07:55:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e2628sm30874665f8f.6.2026.03.31.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:55:42 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:55:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <20260331155541.0451cb29@pumpkin>
In-Reply-To: <20260331111428.0b0575dd@pumpkin>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
	<20260330132003.3379-3-david.laight.linux@gmail.com>
	<202603302335.0AEEF9154@keescook>
	<20260331111428.0b0575dd@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 11:14:28 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Mon, 30 Mar 2026 23:36:07 -0700
> Kees Cook <kees@kernel.org> wrote:
> 
> > On Mon, Mar 30, 2026 at 02:20:02PM +0100, david.laight.linux@gmail.com wrote:  
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > If the string is constant there is no need to call __real_strlen()
> > > even when maxlen is a variable - just return the smaller value.
> > > 
> > > If the size of the string variable is unknown fortify_panic() can't be
> > > called, change the condition so that the compiler can optimise it away.
> > > 
> > > Change __compiletime_strlen(p) to return a 'non-constant' value
> > > for non-constant strings (the same as __builtin_strlen()).
> > > Simplify since it is only necessary to check that the size is constant
> > > and that the last character is '\0'.
> > > Explain why it is different from __builtin_strlen().
> > > Update the kunit tests to match.    
> > 
> > See also
> > commit d07c0acb4f41 ("fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL")
> > 
> > -Kees
...
> That really means you can only use __builtin_strlen().
> Which means you'll get a compile-time error from:
> 	char foo[3] = "foo";
> 	__builtin_strlen(foo);
> rather the 'not a constant' when checking strscpy(tgt, foo, 3);
> At a guess that never happens except in the tests.

I wrote this change a while ago, I tried using __builtin_strlen()
but got a compile error in the tests.

However I've just built an x86-64 allmodconfig kernel on top of
my patches with:
#define __compiletime_strlen(p) __builtin_strlen()
so something must have changed since then (probably related to the
__nonstring changes).

So the actual fix for the above is to use __builtin_strlen().
IIRC it also detects a few more strings being constant.

	David


