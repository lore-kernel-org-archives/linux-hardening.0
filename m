Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479FC181321
	for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716754; cv=none; b=Bugf5I585k63emVlkdpJcNlHdv+73CCXVb9OTnXCfT1LLoHMo/ggpi+8XUxiT8ZQJqNrHygoL++12nPuq5/4vq2mL78egPM9x2SlW14RmQb1+XIMiowGEy7OHys3S4PI/F18JRcOUzUWXyy0CfkhgWoboC1PvsnLiILPqsvouhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716754; c=relaxed/simple;
	bh=ASOifTaYkEbXRoLvAaMixYKD9XKfRPUvH9WBVQA50zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYZAfQIId6fwZlCnd6LDcI2Pb+1DwyGZYUeSQVtJI20twQNTz/TnjhqTXMPcx3i+TGk1yLvFXSKPBjK1NsPd5sYv4iS2dACNH19v0P2NGVH00VkWq4NNM9EPMn+bQm15Ao9u+3R6MpapZbTCdWbMo1YdC2lIYcewF1DMC+jYngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HPXv4VCQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HPXv4VCQ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f44b296e02so3540191b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715716751; x=1716321551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDIxmO8O4oEi6F9/Vlt0Coyv3oXpib+ejgDTpJEMwH0=;
        b=HPXv4VCQ96HCMttF6cbDZYjLbSbamVwhiOhMLs2cGEEE/qpPB49kocwL7dB6OfOCWc
         whqo/2wO6AJuGJ0ef+o1IDAMnO09yqZ9DjvpjxJ6IpFKX+DLdwq2huvGaImirHtwwldW
         qA5XIUX4HkS8lENF6u984pqx2gDaVlFxsfglA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716751; x=1716321551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDIxmO8O4oEi6F9/Vlt0Coyv3oXpib+ejgDTpJEMwH0=;
        b=OlveVp9nM8svpM05f6TOvdYyXeC2EAZw0fgCFIDUsldPluEJsw/T2+e/RSw10T6t/E
         g0yXR0349ltjjmh7/rI/UzQQNx7zS5tE/zvg9JYK2AuXjKblPaIApN3r3vjxJgCYFSgy
         tz6EgYQyhZxd1qa5ACjr+AeMofI9/He0uqvxw/25/EOEP5PkQLhiZJoOJQ6iqFXSt53d
         v1ys4f72SAIA4+4p9heFgNlz5tUftOLSqKfqxKGn3jlqlP7ERrkPREnG9dHRg5zIzx+q
         1TN/yOyX/9FTAy3m3YS7d6uRksp9jI8xIJg5+ivaapH0oMmG/TjatASODRwCkILNlcZx
         vejA==
X-Forwarded-Encrypted: i=1; AJvYcCUSCRuGeKlSWxd08rEZJYAJOcvghCyLafwFhQk7Yxs/+OjdWOwscUVRKjc7KPmO2NJ8KOfJZPBlhayuGUbM3XvUTdgXrDb9CgPSDmhIFPK3
X-Gm-Message-State: AOJu0YwwR69S3TsObNzm1ACGBfAF6ZPm6Rhh19w2rmnB+TEiFFiOZGtJ
	wyhwt+Mvw/jVrYQxT2UHU3wFBOYWO8SOhfqHi9ISn45uPDShsjOXq/ocsgv6QM264xvBJ9IN9sw
	=
X-Google-Smtp-Source: AGHT+IFMsUNE1shtNKBoX9RzuQwz1fwsS0gskM8WW1Coq2tK+eDh8hIV25DdF54UPDs1+2Ge75iaTA==
X-Received: by 2002:a05:6a20:3c94:b0:1af:cd4a:1e0c with SMTP id adf61e73a8af0-1afde0a8d6amr15225799637.9.1715716749654;
        Tue, 14 May 2024 12:59:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f5028d7738sm4031400b3a.71.2024.05.14.12.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:59:09 -0700 (PDT)
Date: Tue, 14 May 2024 12:59:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: remove meaningless CONFIG_ARCH_HAS_UBSAN
Message-ID: <202405141257.3979DCA2@keescook>
References: <20240514095427.541201-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514095427.541201-1-masahiroy@kernel.org>

On Tue, May 14, 2024 at 06:54:26PM +0900, Masahiro Yamada wrote:
> All architectures can enable UBSAN regardless of ARCH_HAS_UBSAN
> because there is no "depends on ARCH_HAS_UBSAN" line.
> 
> Fixes: 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Oh, er, we probably want the reverse of this: add a depends to
CONFIG_UBSAN, otherwise we may end up trying to build with UBSAN when it
is not supported. That was my intention -- it looks like I missed adding
the line. :(

-Kees

-- 
Kees Cook
