Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDC5C96;
	Tue, 15 Jul 2025 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560676; cv=none; b=tEHIU2S9dxtibryCv3QEIuWZjLyvKxgvIc1lP3+eDFYYqZdaJ3EIzQx58l1Kkux4WgytmMUU9aaYxXQcFAW0J7/4GzDAMCdUgCOjZy5TgQob1HHjJ9MZ6bVlBxK/0bVGapKoxiV5Tea/Zmht7WXzCnmXRSRVlzVvtrN/PLrmFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560676; c=relaxed/simple;
	bh=pIheCZzLwQSccd+p0Kdaf22imRlMrA1HICkSV+MknLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XcV00jlGbQRA8IIUfQBGabQNKD8R/92vkwRW7Zk0zj3FTGtet+zyAGkZHMZ9ca1/JncRjZIkZpb28sgd7Uol6Qtwf2+Q6gPofD1anITA7R5qHQcV3EyAgOzp81ZfLFEkzWftmLAm7BuTl2CYpRU6QKMqJ39P3QRN3b+nlovcfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPOP5Mau; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPOP5Mau"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45629702e52so415385e9.2;
        Mon, 14 Jul 2025 23:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752560673; x=1753165473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w4VYgGFTZ0oWXLLm71NTBXounZsQLYQkCK9H7WBrTiw=;
        b=MPOP5MauGWRCaWCtTRd98TrZ5E+ideJgf8TUq1XQ1WKmPSVcuEUjDHSKWs6dT2UKpS
         WshLWVC/Qysc36jCujI3SBCEqYXmyIOE/3GldbQ+Vzlvxkd1RLlgoxhVTnVk7ApMg2FB
         lWcFNevHVATz7fXo2Xtmum5hBr3+ku+5SUpdM6zpvxtDCsQ8MYs81Yk0TgPjcY4Uxvn9
         jla4ID0lJAAkn190uHmsQKarbWxu+n8+Zs4OO9VCWGbGQz9fl5HwON0bjYDZiTy96Qdm
         T+aYSl9Nzzldu8jxS4Lx3sWfZThd/jJ/QxmQXEyLap/SNxzDuVeW7XSaYkcRNVjxCQJe
         CzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752560673; x=1753165473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4VYgGFTZ0oWXLLm71NTBXounZsQLYQkCK9H7WBrTiw=;
        b=Ghz1dSwVoJiG8byrO7PZ9icwOvNMFpJphJwg5gFjU423s3hJ5UlmsGDpIENrbAr8p6
         xBLc9x9AFl0SzvXhDqFI3jmTL0o7gmaGjIGPDpqfCFmvDhNgzaibPHTGeB6oyWQxGbtW
         sLU5nOG9lADP/lwwWtSZn9SOuB9CbKH5PLZhDBUZaNH1XxBE9Mm/+HLp0Hg4xMhefyI7
         wOsrRLcG6Ax556EmGOAaOVl1bxitKhbkmWr72tbWBELG/ExZ4YcXPf1L9grx/nkGaRwX
         H1wyZVUpnfXzmPWrF9QSrOXtp2FcdZFyfYeRkTcViF8AsyJbEQPmonVYPbNtKXf1bK8y
         LVLw==
X-Forwarded-Encrypted: i=1; AJvYcCW8cZKFPrrkq7dWIyYAHueClEvOQM1qMP5K5iKIO1L2G8NAlGv8R+SIy3PqDtzayHI/zMht9BdUFvHpIFeVyP8=@vger.kernel.org, AJvYcCXYJ8WtE7azyVIm6dv85H2enZ/J+leyGG46d0rnGpjeOluEA1/sJxPNCpEVFRWa5Cagfpalq0CBRDlQ07eo@vger.kernel.org
X-Gm-Message-State: AOJu0YxNh89Q/621/QHnyD06Mjq/tIFN+rNhoklb7DIopsUAeHqJNewR
	77tJwjAEo7GH3ML+PuUxCgIYDd+GLIqHa/r+qZxit25E7O2M1HkDVdc+
X-Gm-Gg: ASbGncvMZYO89mZxOWsHRyqaAq1ELYjx+nPMhE9LDJCeG0quejGz3SkoVrsvg/uoV+/
	kW+8Ak/u24pRTnETPZpXoNTnYIkkNVadKhmS3mZkU3n9gHef63WQ4Dd0MdkXDYpA8kJ7dO/f4l7
	cVvGcJ+IA+DdUK/yDv6B1D+gzKDn+3eP0LDE5FtcJ1nslcFxdQPkpSG36aeSeyucMVRfRoPx+DZ
	hAEFartAJKWVhF5eC+uuKNTRztA2hqguO0FRLAnKNRHVHxiLEa+QAFq2E2jurPIk77Bsck7TkGQ
	dLllOJS8cQlmeWQ/XlpQGgUgATHLtz9Uvyr+9bLPJwQfez/kvbGxfLgjcr1voWJDCquBKVfshw9
	U7DTMojEAUZkBkuVYDMztLtt2Tlgst0mIqivM2aZcbDUZCOHlLcQFJcZUuMhaBiUqH+ulPy+0Sq
	han3LfgxodwKiXvBhqn1JWZ4qDcEMvXCFtuWNGN8xFplWwBw6e+ihGFs2f2r1xqCNndux26EQVV
	CmTrfLebf63R0IeanMb8mqLBk+ocy0=
X-Google-Smtp-Source: AGHT+IF2hnsQQRtjZ3XwiS2AtbVps6NptTRW54j6itYDX0j1M77jgAVfRUrduf0BsARXSotYoztRng==
X-Received: by 2002:a05:600c:8b34:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-4560f1e27femr88140865e9.4.1752560672656;
        Mon, 14 Jul 2025 23:24:32 -0700 (PDT)
Received: from 2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at (2a02-8388-e6bb-e300-2ae5-f1e1-5796-cbba.cable.dynamic.v6.surfer.at. [2a02:8388:e6bb:e300:2ae5:f1e1:5796:cbba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455f8fc5a01sm105198855e9.32.2025.07.14.23.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 23:24:32 -0700 (PDT)
Message-ID: <d43ebab47ee70cd11bddf78c424ec341b4c797cf.camel@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
From: Martin Uecker <ma.uecker@gmail.com>
To: Kees Cook <kees@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, Alejandro Colomar
 <alx@kernel.org>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
 Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow
 <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov
 <dvyukov@google.com>,  Alexander Potapenko <glider@google.com>, Marco Elver
 <elver@google.com>, Christoph Lameter <cl@linux.com>, David Rientjes
 <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin
 <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, Andrew
 Clayton <andrew@digital-domain.net>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Michal Hocko <mhocko@suse.com>, Al Viro
 <viro@zeniv.linux.org.uk>,  Sam James <sam@gentoo.org>, Andrew Pinski
 <pinskia@gmail.com>
Date: Tue, 15 Jul 2025 08:24:29 +0200
In-Reply-To: <202507142211.F1E0730A@keescook>
References: <cover.1751823326.git.alx@kernel.org>
	 <cover.1752182685.git.alx@kernel.org>
	 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
	 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
	 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
	 <20250711184541.68d770b9@pumpkin>
	 <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
	 <202507142211.F1E0730A@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Montag, dem 14.07.2025 um 22:19 -0700 schrieb Kees Cook:
> On Fri, Jul 11, 2025 at 10:58:56AM -0700, Linus Torvalds wrote:
> >         struct seq_buf s;
> >         seq_buf_init(&s, buf, szie);
>=20
> And because some folks didn't like this "declaration that requires a
> function call", we even added:
>=20
> 	DECLARE_SEQ_BUF(s, 32);
>=20
> to do it in 1 line. :P
>=20
> I would love to see more string handling replaced with seq_buf.

Why not have?

struct seq_buf s =3D SEQ_BUF(32);


So the kernel has safe abstractions, there are just not used enough.

Do you also have a string view abstraction?  I found this really
useful as basic building block for safe string handling, and
equally important to a string builder type such as seq_buf.

The string builder is for safely construcing new strings, the
string view is for safely accessing parts of existing strings.


Also what I found really convenient and useful in this context
was to have an accessor macro that expose the=C2=A0 buffer as a=C2=A0
regular array cast to the correct size:

 *( (char(*)[(x)->N]) (x)->data )

(put into statement expressions to avoid double evaluation)

instead of simply returning a char*


You can then access the array directly with [] which then can be
bounds checked with UBsan, one can measure its length with sizeof,
and=C2=A0one can also let it decay and get a char* to pass it to legacy
code (and to some degree this can be protected by BDOS).


Martin



