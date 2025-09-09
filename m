Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FD2D3ED7;
	Tue,  9 Sep 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421479; cv=none; b=laKDac8dzPT/4pEx90uCNUlyWsguedjb4rP3LmHV8J2dNZuPu6VURxy02o/5mneHdVpB1v5IBhAD/ppF/r1OdEUfpHRMdZqwBPBi+jMZdeMNe1LuidiynlOCJ0LdiLFIDoyN+u0Tt9vGn+LBA9KSoNEfXygBTUecFxvEW5UlFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421479; c=relaxed/simple;
	bh=AwlCg6UHOncWugo3loGql859Ew84PL/D9QEznoNdr4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYXPTBw/kXDrHCtf+QJnkyInQl3uX69hD0mUOTVqs34dOy1m64f2lLCdzTF4KtK58uza1eR5UsF5ZqFFDRN5TyIeb3I6s5voJswSMDsdg1GJ73ujHAsfR/NszAsrKMb/8XX1nzE5ain8Ru6jn+DSZodQEIcoVFcEJvudcu1qbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K8q7vAU+; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K8q7vAU+"
Message-ID: <71629bf0-9c61-47a0-a56e-664bde0ba853@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757421474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48/xwh638NkFUCq4et+8iyMSrrRkWWc1f9x5JOS6UrU=;
	b=K8q7vAU+GggklQq47Rd7nds+ybARZaP6wmn0tzNbBQgLmexzx/99WHXN+/9G9R2g2425Yv
	lhJ+97Q7LmIQumu5YVmWTvuTQ1LM5u1LPdHz3X/nSYYEzrQ5URmt9GaX0raILlrMdMYr1U
	hMlnHEEvXEBt5i8BXv23OaPDeoDD2y8=
Date: Tue, 9 Sep 2025 13:37:34 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v11 1/5] net: rnpgbe: Add build support for
 rnpgbe
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-2-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250909120906.1781444-2-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/09/2025 13:09, Dong Yibo wrote:
> Add build options and doc for mucse.
> Initialize pci device access for MUCSE devices.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
