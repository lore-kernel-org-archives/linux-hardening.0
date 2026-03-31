Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EB3B19A6
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947495; cv=none; b=RB82XqfAb1uoBeDRzGBs57kxXNqb2hBVRzcWK3TiFuVLXSfNDJlsY5YaYVltkBbWLNiq6Vtow8nfeHrXo/NUY2zQlCSnNFaLfwrCykn4VoVtXtlxQVLmMIEgrmgsZvDQz+kjsfkw0E9oPXUQmmkizwg3hKSmdz3ag1q6OaE04Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947495; c=relaxed/simple;
	bh=d7YZnLvS+h+0HdiguMBa6VMgZIVwCHnjN+73m5Nnd1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4euNmOykUPb5IELr8iVdsgIQbruXP1aJP+tVb+SziJnGalWKBMDpKfMWxQ6D8qsJ0Jd8USR7jehKedtnoAslxh18G/IpTq1leRBEg0fb/LCUZAtliL0yqFtP+DfnZmtwoO0R/j6sWyq/uUXz0R3YOkOOxycfGGrtS8ee2t8VP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOx1ewDn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOx1ewDn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so48860765e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774947493; x=1775552293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUBFmNIoijQTwDFycTPLWNTUdbsDcUl9Qdi01ngFzW8=;
        b=dOx1ewDnLnvyrv2L5daLy9oAlTrhV+xzEsgJzWmqojXpTuQ3xN82/JhbRoKhNi0KxO
         JQW/eI+4a3a15gaOAHL5dHrevzObRo5m0rzk6a4S8tpB8/IQSv3hVQAWHo9DTuINA/Mx
         15YgIYpMucBC0LfqF1FcmWfHyfGQ+l8M9TGoS9hzWUe7OmUzp5T1g4VwMmHQPXpna/Y4
         tyIGqZ+e0YIvJCpZydaKPxsmjfxWvm67vf1ImISvJbz5EbwCkp57L+gy/ubwSg9i4+su
         pg+w2BzS0NU6PigVLJnC6rI+NCMhpp1EYGlUoDau/OHx1zkyRJs3MvHck9wEo91bQBr2
         8/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774947493; x=1775552293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xUBFmNIoijQTwDFycTPLWNTUdbsDcUl9Qdi01ngFzW8=;
        b=cSq27vcZleTeAM2JfMQi3DZhdV3AYS6zOA2CSEFsY5ErssSb/R2ynVB+erCzVGpl4u
         HuBWkjGfLy79IpDpwrhn+rsx7LzSbX0MuR02cYF0vopTRsf9wlYBYunltSltGFe9qwUL
         kvdQgvJaj/gDHG115Rhg+IJXQjCB9FOwohrfyRc9HTAsA4CfFbiD7HePYlkVMFB/kvQc
         9d6uOH18e97OZ8SdtKHann/4CF/BFetawfqV5fyMCGLtr2nqAndcHtfDCGIrxPhQJd5L
         nGkFjQ+7Y6/jXe2I7xNpFhKh9eMqM2zYSx1JQBtPWLQht3Uj3pwi7bshcp9g+bStRY5I
         MBmg==
X-Gm-Message-State: AOJu0Yxa46ASLPsS0PnnQ/LG7Y68dlkDHM1RhAEVrQwfvxYbVxfkCNm6
	sMtd5ZCvs+E9QY1t2MRHp1FypkrSgAnkOaBQmdwhHsCilvyMFnNiC9t/I2gajCo9
X-Gm-Gg: ATEYQzz8OI9VLSMzwXAFucoC9qSOgxjzFL0/gzts65FkrJ3pEZhPmDMSEzWjbdzRb/v
	TSGCSCn/YHnAJuGoVEPQSL/JgEL0sJ25nHt+Jsnw9iID93U2OOdrSp1qEIIRV5dyIb6vHZRs/oX
	szG0KXp+NleWBCLw5kOX7utLekQU05U1tE4/0yGw1vojdaaFQtbXS8EdWEwIFcJng+3reQMob1o
	0mFlMKjFcbbe4E9eIFMFIs5ODsTWM4glz8nR5WquJrA6V4NhjtZLgBhrxCbMSLaRMsXRjIL9ThZ
	m6HLIXyqR4+MR4SE+FHB1BePmFZ7TbSlAoFSHU8iPAdXSL+c+iRU0xHoJNoFO1DyaYEGIAZRyFp
	dgG/B3AJBgCMCZT99Gk3ioGMJX3VOR6DsPao3FjYeQ+voTiJOWSUtj3xGSat/1jFIIHlxw1lxg3
	gmMqkVPFZDRgr1z7HqUQps+nm1Ztnj3D2RIW2ASe3VVBV/JHe50myzzswdiZfj
X-Received: by 2002:a05:600d:1c:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-48727ec7681mr205715195e9.21.1774947492313;
        Tue, 31 Mar 2026 01:58:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630901sm19437755e9.0.2026.03.31.01.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 01:58:12 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:58:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 3/3] fortify: Simplify strlen() logic
Message-ID: <20260331095810.30da7b05@pumpkin>
In-Reply-To: <202603302305.19F4EF8@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
	<20260330132003.3379-4-david.laight.linux@gmail.com>
	<202603302305.19F4EF8@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 23:07:01 -0700
Kees Cook <kees@kernel.org> wrote:

> On Mon, Mar 30, 2026 at 02:20:03PM +0100, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > The __builtin_choose_expr() doesn't gain you anything, replace with
> > a simple ?: operator.
> > Then __is_constexpr() can then be replaced with __builtin_constant_p().
> > This still works for static initialisers - the expression can contain
> > a function call - provided it isn't actually called.  
> 
> But __is_constexpr() != __builtin_constant_p(). I will go find the
> horrible examples of why this, too, needed so much careful construction.
> 

I know all about that.
Loosely __is_constexpr() requires that the initial compilation pass
sees something that is constant, whereas __builtin_constant_p() can
initially say 'not sure' and then a later compilation pass (eg after
function inlining) can determine that it is true after all.
There are a few places where C requires an 'integer constant expression',
otherwise __builtin_constant_p() is good enough.

__builtin_choose_expr() is also pretty much exactly the same as ?:
except that the types of the two expressions can differ.
In particular both bits of code have to compile without warnings
and have to be valid where it is used.

Note that you can have a function call in a static initialiser but not a
statement expression ({...}). C requires the expression be constant
- so the function can't be called, but it is syntactically valid.
So if you have a ({...}) in the unselected code of a __builtin_choose_expr()
you can't use it for a static initialiser.

Once you've relaxed the __builtin_choose_expr() to ?: you can relax
the test to __builtin_constant_p().
That is then (usually) true for constant values passed into inline functions.
I think I found a few cases where it made a difference.

	David


