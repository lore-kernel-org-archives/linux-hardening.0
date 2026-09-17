Received: from k25.k3ae2098.use4.send.mailgun.net (k25.k3ae2098.use4.send.mailgun.net [204.220.183.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6344A5C33
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.220.183.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789681018; cv=none; b=Sp2iGIbsqq+tTf3axdIDvTBE2NrNOb2HkBtf/I6l8biyGHWcGNt1K67D6HKBQb2ZXUm/vdRPHpCwCeHeCzTkKjM4cB8661OBbS4VGKNE2gA9C9KW+WaXLo551h8FLmpE9M8UuTywVvaexGniHStCjkexxmPjXamZMbuIp5UDv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789681018; c=relaxed/simple;
	bh=t3N3cMXiQFEq4nhxvATM3kN0reVjqgVeSWrzjIzkV+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlWZhLjPxoZrUsw7Mj9mWbmdwzk9r2z6gX4kp04saeRRDQLbGbYs9WiH8cqXpAOkXFsmvI3BEL9Q6FS+lxarjOalT5iSBQo9Cadhs5DLqg3pzOlisgbzabjr6rmZG4v+1kfMZf5Z/33nHpb63V0DLaG24skT1CIQ15pk9fCIUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech; spf=pass smtp.mailfrom=equiv.tech; dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b=mQyz4vp8; arc=none smtp.client-ip=204.220.183.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=equiv.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b="mQyz4vp8"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt; s=pdk1; t=1789681015; x=1789688215;
 h=In-Reply-To: Content-Type: MIME-Version: References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date: Sender: Sender;
 bh=tmCjTtf74fJzZCxzPTtdpsX+Bj9MyF0VdQaJp6zwaZM=;
 b=mQyz4vp81lPA9eTLGl57xhZdJQyClHEu949fRLdpmzB/VPCZqvYdMlmCpvplLCq3/IzzwEEITSI5Rb8YYU7QFr4rx5vOzAMVodw6An459Wq8ilBR7S7ZXV5qnBgzJpLbYCYRC1JJ2OCC2Y3+vNaa6AujYFbiPzXzOHW4fzo6yKWnyiezplDYf5OvApOYWBgonZ7w4seHJEwHFNBORIiKTKDu25DMbpSdwV1oW8LNUobyp44C3OzXG3wcL9m9YyS90pRW+ZMoaNsXk7kH1nt79Ozie+1nfY9bLCJ9tkHM3jWhS6ejt6uNrxlzv5QOsXoY0b8kuXVJAPayo4w5KxHCog==
X-Mailgun-Sid: WyJmYjNhMyIsImxpbnV4LWhhcmRlbmluZ0B2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by
 1d83990cfc41646456b83b879f462e6ff8167ee03124f26cddc22a86bca75460 with SMTP id
 6aac5d772dfa5e6eb605ceba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Sep 2026 21:36:55 GMT
X-Mailgun-Sending-Ip: 204.220.183.25
Sender: james@equiv.tech
Date: Thu, 17 Sep 2026 14:36:54 -0700
From: James Seo <james@equiv.tech>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: hp-wmi-sensors: Fix info_map[] allocation type
Message-ID: <aqxddgcDH1khPlwq@equiv.tech>
References: <20260917211338.i.682-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917211338.i.682-kees@kernel.org>

On Thu, Sep 17, 2026 at 02:13:39PM -0700, Kees Cook wrote:
>  drivers/hwmon/hp-wmi-sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
> index 03c684ba83bd..cc193a8890f2 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -1788,7 +1788,7 @@ static int init_numeric_sensors(struct hp_wmi_sensors *state,
>  
>  		if (!info_map[type]) {
>  			info_map[type] = devm_kcalloc(dev, channel_count[type],
> -						      sizeof(*info_map),
> +						      sizeof(*info_map[type]),
>  						      GFP_KERNEL);
>  			if (!info_map[type])
>  				return -ENOMEM;
> -- 
> 2.34.1
>
Acked-by: James Seo <james@equiv.tech>

