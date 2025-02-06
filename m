Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1141ACECD;
	Thu,  6 Feb 2025 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871823; cv=none; b=mpAYyOKAcGgQSCm3OIm37YCJfOMfKoEsegCXpO3VWNGVmyaDLQVLhdP4E7l8X6dKeJH4EB74KPdnQUeOjXKb17ADANbh6kCtxubNDJDjtG5X7T5f2O70+J/udlpMnP/f5gXkD4/EBdDEDUNb5eUocZsQff2eKi37R4KzBggF1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871823; c=relaxed/simple;
	bh=m29euKP0tRbm1pfzPENkzHxEPSHo+gfSNXCTL4qfmug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4MUDqFj7cuMGFlFiJHh1pmBuVJGK3Le8yVHCkmrsbppNysxIjWvdHnmrpbxmn+p+19ndYn/XcJZu9FXLOD5hS4UOhxntdXxnMmB97YsAu+fOgtqHAviomVJB3wqHZHWRS0mocJP1u7OPurN/69mP+sxbPsiUT9/k/AjCwx0w2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jetr4/rz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jetr4/rz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436249df846so9171645e9.3;
        Thu, 06 Feb 2025 11:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738871819; x=1739476619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BcIyHBsPlzNpYJRzgarV1TA18Vy0KuhGFQwaCUNHPs=;
        b=jetr4/rzDMEh8O0BjburlQDc1LV0TPoi74Wa82gewpBfCeIrFbO+eNrp3scnjnyeKB
         FQehsVVtCM7BhGbxJfQWx8JibQukhaPRnQcQ5I1zd6zRQLjiIspIiuRM38BmTXOiH7He
         NYCcW5AWLr14OCw0t9sPyLYEprrpskvwQkvDgq0JOeT+UhlF0FWt5P5TCOhazak9MGd6
         LH5RlF1ck1BSl1reKfcq9E5R/jnkWxR0wsvHw9sjaEXHuqbeL8UouhprygtqPkVLU4uh
         hk+wQtApzaIx62JYdJoOGg3Ofr9uEchzGh+WCy6zgSwS/WFWJYAMasnsMOiC2nThjS0Z
         Yvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738871819; x=1739476619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BcIyHBsPlzNpYJRzgarV1TA18Vy0KuhGFQwaCUNHPs=;
        b=NgOPXCJbhy+Z7uxIpYlVQvtyZWfu9SK+HYdfPFSwu7brnl1dzSWDtVTIaLePngxzrc
         3aG8R2kVbCQSC+ijBxKL33UTK1k97x0OhUE7LxKKzXosSJbLCLwrkEC6OzqSX6/zDAnS
         9mP/mGLxn+/GLLxQl6+uxXRfHtL1RutDP/TQDC0HohQED2O9YLZvvujoB3gWeClb2nim
         TQpBJmQJa6J68rnqQDAkUiiTYXS9K2pr5P03gAmmZRBW5YLCYgKMf0/MIWTHUum9/vVf
         HV/ebGq9Im+2D7ASfJCGdE+DPQjp6eh1DoS9pYR4aXhmEb7/Afb3bLgoisJur7qA1Fc3
         MdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8cDwiItzo7NSPMCiZNhlbLgbjjlO/n3MFDsh+BHX8LZUdsj9YQgMmqWQl22zXGxV5s4KQZfgTbPVc22/3@vger.kernel.org, AJvYcCXwqP4k85cv9ZN0vhC6LIZg9fABDoxIqtB70fnXzc7HSEdMCNokSMPiVGV9WNejsP/Lthk5wDJ1+8J/xiIem78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7weiBd2YbaVFmOCeSlMvUWuYPr/+mXB0ufACGEB2K98VqLfE
	+y6rmuFUkDul83b78nXrlsB+8KA3euXp7GBnr9ScbJHHBqMPfHCT
X-Gm-Gg: ASbGnctVK4RarSjSXVLqbxpXcbErMnD/+FLL8R7zaEsAMYqk36ukeBxsBLMDpfdY5UV
	NfqaBjJFqmE096iGAIuUJBFR+DA1LW6GkqIW0z0LXq6NZgn3ii3038leMnwHklThAYzEnj/teZU
	jbRX1a9c95E6pq288KUSsAyguu1ICFbRkV+hWEZo8s5J/C9lXK3zz1a+vN20u1e1Tms0os7n6h+
	zkZQJerxmrVkA1hGGLEYlLVSWs5cxZJdCPhSYIQ+akEHSggM2W9VbJpfAs1wMOAOjsvv35l3Cxg
	iHvdl3VBJc1Wv1/bgeAfGiSHe19OouU4BM1aVpFmS3fiJ4AVmJ8DbA==
X-Google-Smtp-Source: AGHT+IH+OL30IFfRMNsPtlHNYkTxJSj4lsGxvGMTQ+15ZtUvzy7gINcPStM0hCceknYWifHXCEqJGw==
X-Received: by 2002:a05:6000:4009:b0:385:fb2c:6021 with SMTP id ffacd0b85a97d-38dc933393amr186251f8f.39.1738871819474;
        Thu, 06 Feb 2025 11:56:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde0fe37sm2561146f8f.69.2025.02.06.11.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:56:59 -0800 (PST)
Date: Thu, 6 Feb 2025 19:56:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Andy Shevchenko <andy@kernel.org>, Luc Van
 Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Philipp
 Reisner <philipp.reisner@linbit.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] compiler.h: Introduce __must_be_char_array()
Message-ID: <20250206195658.79231973@pumpkin>
In-Reply-To: <20250206181133.3450635-2-kees@kernel.org>
References: <20250206175216.work.225-kees@kernel.org>
	<20250206181133.3450635-2-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 10:11:29 -0800
Kees Cook <kees@kernel.org> wrote:

> In preparation for adding stricter type checking to the str/mem*()
> helpers, provide a way to check that a variable is a character array
> via __must_be_char_array().
> 
...
> +#define __is_char_array(a)	(__is_array(a) && sizeof((a)[0]) == 1)
> +#define __must_be_char_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_char_array(a), \
> +							"must be byte array")

If you are only checking the size, perhaps __is_byte_array() would
be a better name.
(You've even used 'byte' in the error message.)

	David
