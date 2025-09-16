Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DC320A02
	for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035951; cv=none; b=uIOgG+WDAtnyza9PY2HzWqqhR4V1sUaBwYqCzO5IhV0IsglS7mSzO0lYOemYeVZgPwaIYxHrVygwahVJ3HVxm2eqOZKPWTYPGMZsJeuC8tjy2pIF99WA7+3uPa5IXMR2OTRb/Y7xUmhKDunDREfoQBS2psDHxVm7k1oQhJ2Q7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035951; c=relaxed/simple;
	bh=FO+jHHeUsvXK1eWyf6bU8V7LgSITdQZaJd79sSBRis0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwYXNFhHTeEWVb+nC2hZWqx9HPsvqekOh+yPtV9NchLB2Z7u6DubbY0UW+lVeVoVzNrvB7kIvEvp5ZoNX9DUQDnvAmzq5TYTWtAsuxQ4abQ6dPEy+uJ7g86VBUbGcudw5CrTm/m6FVeF4JE5t1nTnc3qDeu0yqV9MXEVEufvtKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rzcqHiy3; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rzcqHiy3"
Message-ID: <39d7268d-b3d2-48d9-91e9-06b5fa478f9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758035945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFfEYMIrjsBwsmGW5Qt5zbm7Ygai0ZuiCf8oxNTXzZA=;
	b=rzcqHiy3wmNM4rkKVoOHEMxW2YtXAnbWKiYzDbCHUly84qRdlRm2runH5XeHA4iJ/zDmK2
	q1sIhjFh3Sss/VeKcDrG6/YZ9ZbMpbKgHFyvfH2E3jYYLB8ohCb3GwXV55DTSD02UFJpTM
	LjukgIK1RbuvoWKzMqUeWr098R49VpM=
Date: Tue, 16 Sep 2025 16:19:01 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v12 5/5] net: rnpgbe: Add register_netdev
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org, joerg@jo-so.de
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-6-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250916112952.26032-6-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/09/2025 12:29, Dong Yibo wrote:
> Complete the network device (netdev) registration flow for Mucse Gbe
> Ethernet chips, including:
> 1. Hardware state initialization:
>     - Send powerup notification to firmware (via echo_fw_status)
>     - Sync with firmware
>     - Reset hardware
> 2. MAC address handling:
>     - Retrieve permanent MAC from firmware (via mucse_mbx_get_macaddr)
>     - Fallback to random valid MAC (eth_random_addr) if not valid mac
>       from Fw
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
