Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16499212B02;
	Fri, 10 Jan 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527942; cv=none; b=NIVqgDOh3fb5IkED2HrUsq8a+rdNW7KrShi9cpf2mRYLcQrLAHJIUiqRtSbD2WXxkUK690LqJJ6Ny4fxCfIXoRvkA45i8OCQkYG45aZOY2Ui0PmtAN2aiXcn8sSjWO49xgQ4isNl9pZl5ot34g/5ISWwxM3m1ljirP3D5XD+pi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527942; c=relaxed/simple;
	bh=2iDuBUHDM6pe8lx2e+EJ1C11Te3LUtYB0Fp14CLTr5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qxt1RnFHN7L4UUUpNSIgyG5I6RyDNOniFV7dl1T7BrVgcIZzZkSHFjeojHrp4DjDyirVpKEkC3V62Xws+JQYTdoefbV3eqP6IHkOyHbRWwMBSApI0pCZPn5HSIoUGr+Fy3ni5/yRz91xvhPuH3HU82HR49GeLFyKM39VDo+DZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSEVnB05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSEVnB05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28F7C4CED6;
	Fri, 10 Jan 2025 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736527941;
	bh=2iDuBUHDM6pe8lx2e+EJ1C11Te3LUtYB0Fp14CLTr5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSEVnB05CwzXRuLkq/EMwPB1jobFwvwczP9w/JuHWwVrOIpk4os7AIT9BWsaCSY+S
	 Hot8AF3yd7HmRwsAi0/uvqhxOAlsNWeXthEc4t3q+i3Kvh6h8YYnecezwq3BnuUShE
	 glpfNIM+gcrsSAbVGfIheIqhPoVbwL7H0rYChmROk4q/sfDG7mUtOwAOgTWpChZhp2
	 aaIwYmNyWZgiv0f0P3F3kDwCpSnPWT4sm5kY51o8ZF/gUzSf5GNjcqNQ3xEOCYE0rs
	 0hQC53QBWR4l+scMzkOnu8oVg0OOeCWCpU4oQ9PfeEV9Rj04f/jzVj/UN07FFyBp3/
	 ygxYZHrz+/ntg==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WeiXiong Liao <gmpy.liaowx@gmail.com>,
	Eugen Hristev <eugen.hristev@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	gpiccoli@igalia.com,
	tony.luck@intel.com
Subject: Re: [PATCH v2] pstore/zone: avoid dereferencing zero sized ptr after init zones
Date: Fri, 10 Jan 2025 08:52:18 -0800
Message-Id: <173652793731.3103853.15317559735833434900.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110125714.2594719-1-eugen.hristev@linaro.org>
References: <20250110125714.2594719-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 10 Jan 2025 14:57:14 +0200, Eugen Hristev wrote:
> In psz_init_zones, if the requested area has a total_size less than
> record_size, kcalloc will be called with c == 0 and will return
> ZERO_SIZE_PTR.
> Further, this will lead to an oops.
> 
> With this patch, in this scenario, it will look like this :
> [    6.865545] pstore_zone:     total size : 28672 Bytes
> [    6.865547] pstore_zone:     kmsg size : 65536 Bytes
> [    6.865549] pstore_zone:     pmsg size : 0 Bytes
> [    6.865551] pstore_zone:     console size : 0 Bytes
> [    6.865553] pstore_zone:     ftrace size : 0 Bytes
> [    6.872095] pstore_zone: zone dmesg total_size too small
> [    6.878234] pstore_zone: alloc zones failed
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/zone: avoid dereferencing zero sized ptr after init zones
      https://git.kernel.org/kees/c/067cdf020329

Take care,

-- 
Kees Cook

