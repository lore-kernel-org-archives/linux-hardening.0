Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794277261;
	b=o8FiX3pasA0Cbm8TQ64SFdiUufvtEz/TbCe5RfMefpi5UVrH6js/vKea+utAEFVkva4a
	 YG5b2nZplp02/kj0urnfH/q/5YYz7zJ7DvhAmDLvPLzCopbAqmoDp7nV46KzCjDf+L5tF
	 cRioVY75HDXtyq5pelS78x8nuvvUpUiweh+Pjnd8CWzLR+BQeZPDicl2MYx6BzmvDweX5
	 d706vmV8xHuCix4uG4d4Wz0dbim9fWqYbNJBScz2p+ZW1WJKnv+S7qJt7pZVZaNiDjPgx
	 oQjRh6TusLrkIM3ONuP2Qs/PZpVZsyceKBmhz71avlbbpCp4YPtihCoIPZF3olQVytA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=i2TUUoLgA3e8WVIbMjVbQ79gxzJuaS9VusLU6Lxc8WM=;
	b=x4IJC3E8xx7CZN1l6augmC5cuNXyE4QrloybHapeymWyqzoc0xs+Ejr2MR8VsNk96uKB
	 RCJtfHgppVRUEGz1fnz/A0SMBx2ELzLfAAUNjBV5krsXarOsLEXYk6CiMR/DaJO4+Z2EC
	 5tjcX0676QCK3LzmiahV6EceWdYs9RfheL7+wbETsYLQUROyUkOQRjcgUh0dKVKSegOpP
	 en3llArlQokIL0zoKsiYb/gn56/d/3trBo9cnUN/hBSTt8a0JLYMylhJI0kpahnkHFVya
	 zu7f8TiEXdUADNetJf+ovbsBc733h/I/mlwp6oWzoZWrFMQCZbaax90CQGhY6V5CZEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=efz3coOY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B7606A32A
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 02:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F2B7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=efz3coOY
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so2308432a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Nov 2026 18:21:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794277260; cv=none;
        d=google.com; s=arc-20260327;
        b=hjP9cPkX73XAElRn1AsgW/B+fz5Xkho3YVt8Duc93Fb2dKyAMEzmWwt+ixsXtYb6uA
         04arPyCIHbEC57dVRPhUaCqnxdN1vMdScOTUvzdliKrsIpCNFmJxHtwdC9kQwWH9USbF
         t8i503CenZOEVg0XIKUvTrQyth/6XSzpMXEkXxNfY47MxRYDZgbzfPYOx9t/CAi5ZyDj
         hASzOzo3+W7dhvE2Y2Ov3Uep/JVI89Wq5cDwBhHMg95/J76hyIYgvgNefzc+9KM5qhxf
         6APZD0U0KYIxzuG3w5QY5vOOa+u4eTwHQA187NOIogIDODxZPH7p4aQXY6rdwJfgjlA7
         3Uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i2TUUoLgA3e8WVIbMjVbQ79gxzJuaS9VusLU6Lxc8WM=;
        fh=jOXU4blFL8uyqpbr1vEnEDhoEMmhfikRfANax62GkYg=;
        b=W+C5D3L1p/V2DZ9C9e1OT1Yk2Kk1qlgkIaIUmJ0f4PVJ746xLrNbhdgjDcoJA1k26U
         B3PLeiUZf+KPtWEE0d63zC+2rz8ryvg09umK957dfqBACTmU2E2zp0+87m9njJSWlYsM
         6jr72+wDz2+XxTxMSzYcgpMfxhDF72m9GAW7ZSJL9Qb8HWYBqeWJzaGhkQA66OePZhJ1
         hRRwsAlFjLkiPYX+VbTV+o2c34bHuwULff1+pc3+QgLRqAHDBTdksormk31jvLm2KC5S
         i0QrI6qd07ShRN+03/AfMu4nPzuBrdYMZDGfUHAYk/V34UJdpJs67FUuQ1M68/oO8OU8
         hRzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794277260; x=1794882060; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2TUUoLgA3e8WVIbMjVbQ79gxzJuaS9VusLU6Lxc8WM=;
        b=efz3coOYSr2KjjBCeYtKdmztxPfUZXzmrZuhKN8iiDgBLAigWmRiYCMi8U0QbFK1G0
         cgzKVwIYUXlzJNoBP9wkRFTO/NMb5iqX8ff0GwpBcU9XLNZHjPPqPJ9UtZAzS7VRSNU1
         n5ltnJfdV+WaC+/GQjIHySvCuQ28At27/U10uV6UMYYNX6IaLFonSsffccyXk2BH4HXy
         vfcyxnTGPNSOB6v0f9db9LOG2hWN5Z8JWccLFuV4wctFy6yMgxwXjeuqczcPsJw3Ir5B
         Z1rb50JDKHOoz9Knj2obWH3I7N4IiObhZqVCf658cSxTZUX6KIZi1a74c0FLbTO/Rpqc
         ak5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794277260; x=1794882060;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i2TUUoLgA3e8WVIbMjVbQ79gxzJuaS9VusLU6Lxc8WM=;
        b=kI6B02cGQUls4y7O+VVh9SyTEYuG6z7bJViAEbeRIN2Z4+3jvwhpUqqlvdBJPkgAGY
         QmNva6cvVwNWkjraMJiyslYcKKzYdFrt6oyQ50qb8U5t+cj4JynukIe5Pl6izjA4hlb4
         6mCFPuAhzRuGPlTnL04GaxKbvmcd+WyfQHFI9UaHWOtbv/hUyt4lTxn5HUMwuIgwq4dt
         wUSqvxRY99/LQXdE/vjnLWaxDVwLWT8BxGil364M4yuovbUJwl+8kbPIdBjemLCENNck
         dwj0j59JjNdAH8BujLZE+jVDt9H41dyiS7l0axQPUo9FqMFI4g6itAsroZCuJ5LXFAmX
         SCmg==
X-Forwarded-Encrypted: i=1; AL+hErH/ByuUjIMA/2UQpoR0BhN37IT0k8qYhIRM8YkAuJfrJ+xYeIvdyt3pJjNELn2WK9Lle97SnPaIFfz+SHGQIgk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9t9JeSw/v91zK1Dx4X+u090HOt4b7vudHix+KlWIxLLz1JXFXK
	/86/d4JdZWL9x3XHLzTwFyBHzf0oamdfu61VSaY8s36phAx4Jdpj9kGXKHjt1dOQi/mFm5vDgUX
	4/DStoEc9PQJuaek5TbU+ys373xHkB4s=
X-Gm-Gg: AYBFou3XDPcV5n/Z1XOhS6hC4fbkWelhI7OPusYDoUO4nIzLq2t6aL0XUkNj0/C6Yn2
	FHz31m/HJcVJooFKZ886rwkxNtgg/UjSaw1ln40cBKIribbFPIgOQMtDwGLIJcxLM8OCRPxrbc7
	wTKFan15GX4RmuKoUiMxJ11Zj/Ai8q1Hav886SRThlOxOH3Q/erG91ICVRxuUoUKdfrrEc0/RkO
	yLSDnXHe5qNFBAUV6nYwAe2Ix253b3Rr0IKEyPnvuFSwzA5mqy81n8Cn487U3aFjPu+sT9V3UDm
	JobK1SCOi9mu3cygSNJcq5CVUYWeV7Ek4kTc991ePaXh6RP3sziZfBVLyyf0NhakZcqQRCVrn45
	91Xyw+gkOWaZeScUs6wntw2FW6jb4dhEgz3tTWd0=
X-Received: by 2002:aa7:d492:0:b0:6b4:8d5c:f8b with SMTP id
 4fb4d7f45d1cf-6b75721866amr598705a12.15.1794277259463; Mon, 09 Nov 2026
 18:20:59 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110021622.122490-1-technoboy85@gmail.com>
In-Reply-To: <20261110021622.122490-1-technoboy85@gmail.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Tue, 10 Nov 2026 03:20:23 +0100
X-Gm-Features: AclHuK8bXRdvgJU8KghZLOhvBMXkdeeRv7iNqoGqP4IMZRNV45bXoFiMpjug-xE
Message-ID: <CAFnufp3CwHWxMj8pPPsgEMtCtjUxbwn1VbFd2OijqB8+NA0Ccw@mail.gmail.com>
Subject: Re: [PATCH v7] kunit: memcpy: Add benchmark
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+Cc Kees and linux-hardening, as per get_maintainer.pl
