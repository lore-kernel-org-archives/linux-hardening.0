Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB91925AA
	for <linux-hardening@vger.kernel.org>; Tue, 29 Oct 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214649; cv=none; b=B7aKwUybUxasCwdkP1xZfb6sHn1BJ28IK8e36BmjSiU7gLg7BO3XQ2fHB30fs41HNOyZEMCjk9u+lUv4AkEZ4454xw4isi89Lpa3Dher1URdbnbCLKL8SdEV3cYwU0X3c2oTH3Y+humxwQauU6oDF4pkGcVg4mbG3c6OSdA7TZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214649; c=relaxed/simple;
	bh=pClzO/h/JROTqlyb6Hk2ZQp5fgFIM9FnfxbvzImRHqc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WYPTxYdRYtnqt2LjCK/Csfqktfaw1AB7eoAITK+izxOytJz8WFED5T3d5sf2WrGzIVoa30q7up8trfH+MvnnQEOYY2xUGsRIsM09AqHI/p6uao5npJRSx5f0f8BTJaJu/7eQTlripVGIsKwxnPEBFO9cmh3mSEVYcetFaYrquS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=utgnz4zF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="utgnz4zF"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d5045987dso450569f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 29 Oct 2024 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1730214645; x=1730819445; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pClzO/h/JROTqlyb6Hk2ZQp5fgFIM9FnfxbvzImRHqc=;
        b=utgnz4zFdhOy+7YMXbpmLXje74h8m4lx6u2cnRXuc5S/at09whA4C9h2KfYMSv1JD9
         juWl5Pjp680KnOnpL68XpitftNI24T3uHHls3B6h8LS6+4jOYJhRQG6LghZqE5vofUcx
         QYKmbFMV273ySUzS8eRqM6w0RGwzVk0pirsZamw+23DTNK7+xYE4rIfP3kWowGS5ZNxA
         RkN5LeevWUDzCbTB12hmkt6Cr1vKvfRSpWIeVx02CP9WxlkfjJKZLlT4lEemTONphmFn
         EguMZ5QUpGQtQcHsLIxOvIzRgJg1/76kVc08+ckJ/jnnM+ZZIrXcXqLf0cihOaQMlqmb
         bRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214645; x=1730819445;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pClzO/h/JROTqlyb6Hk2ZQp5fgFIM9FnfxbvzImRHqc=;
        b=vfDh5ZcAzA37DdVl6dfoCpBUyrsqxCv9eELFl20eR9HaWv9+iQmO44/OkfKa4KagzN
         CB1GNiYONxFAbdDMszIEMFZw1JLx5xDchq37YUcKUadvSw8mjVF1Glv/ivAQoyv0eQzh
         kJxIL7tTLHhNCBcXs5+mT/O23wDza8xOZ5NNmsz9bhmV8zaJVz6MvgRTRESfOarw6Vou
         dFq4Dr+306daduK14FrSB/2XsykHwXNYcc88CuDSqku0+SoTPSqQ4na7FJ27V9bRX5iz
         k0Ld9PTpnIZGyIF7WPujSEckUDghcd39XU3D03NcRA5TVuH3HAD7GQf59Lt6Vv54Hhlh
         VlsA==
X-Forwarded-Encrypted: i=1; AJvYcCV4YelZrzQxIjKoyPyItxhaOGCYhA1EEvdg8Km4/UskmfFFJtbYbD6beDKCBK1uLqaHNiY42uwV3mGln7XXndE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZfsVCqTq2X2pc+3HDZxLwJuDSt31ZW2JrSjeeQMMitCZhntr
	/a+e6QsonHyjSHZe9cNeNHLtIoNhPGPZhZFxVw230d2698YHyteRNTakCYOJ8rxjOpjJXTvWP0X
	ybG8=
X-Google-Smtp-Source: AGHT+IHpB0gsXiLgIYq0IllOpj0RLaS+RFkgWPXNM/xk1DTGgHY978z6z+pWhDKYuiUIrS2oulAcag==
X-Received: by 2002:a5d:6d86:0:b0:374:cd01:8b72 with SMTP id ffacd0b85a97d-380611fe6dcmr4253149f8f.9.1730214644521;
        Tue, 29 Oct 2024 08:10:44 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:c1bf:2b25:a6db:6ae3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b713fbsm12813482f8f.88.2024.10.29.08.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2024 08:10:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 1/1] Compiler Attributes: disable __counted_by for clang <
 19.1.3
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20241029140036.577804-2-kernel@jfarr.cc>
Date: Tue, 29 Oct 2024 16:10:32 +0100
Cc: kees@kernel.org,
 nathan@kernel.org,
 ojeda@kernel.org,
 ndesaulniers@google.com,
 morbo@google.com,
 justinstitt@google.com,
 ardb@kernel.org,
 oliver.sang@intel.com,
 gustavoars@kernel.org,
 kent.overstreet@linux.dev,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 akpm@linux-foundation.org,
 tavianator@tavianator.com,
 linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3ADD56B1-9BBF-48CD-81C7-53E10675F566@toblux.com>
References: <20241029140036.577804-1-kernel@jfarr.cc>
 <20241029140036.577804-2-kernel@jfarr.cc>
To: Jan Hendrik Farr <kernel@jfarr.cc>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

On 29. Oct 2024, at 15:00, Jan Hendrik Farr wrote:
>=20
> This patch disables __counted_by for clang versions < 19.1.3 because
> of the two issues listed below. It does this by introducing
> CONFIG_CC_HAS_COUNTED_BY.
>=20
> 1. clang < 19.1.2 has a bug that can lead to __bdos returning 0:
> https://github.com/llvm/llvm-project/pull/110497
>=20
> 2. clang < 19.1.3 has a bug that can lead to __bdos being off by 4:
> https://github.com/llvm/llvm-project/pull/112636
>=20
> Fixes: c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and =
identifier expansion")
> Cc: stable@vger.kernel.org # 6.6.x: 16c31dd7fdf6: Compiler Attributes: =
counted_by: bump min gcc version
> Cc: stable@vger.kernel.org # 6.6.x: 2993eb7a8d34: Compiler Attributes: =
counted_by: fixup clang URL
> Cc: stable@vger.kernel.org # 6.6.x: 231dc3f0c936: lkdtm/bugs: Improve =
warning message for compilers without counted_by support
> Cc: stable@vger.kernel.org # 6.6.x
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: =
https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: =
https://lore.kernel.org/oe-lkp/202409260949.a1254989-oliver.sang@intel.com=

> Link: =
https://lore.kernel.org/all/Zw8iawAF5W2uzGuh@archlinux/T/#m204c09f63c07658=
6a02d194b87dffc7e81b8de7b
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks for fixing this and your work on the Clang issues. Feel free to =
add:

Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>

