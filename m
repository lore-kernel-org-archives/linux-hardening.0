Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D191F3BB2
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163381; cv=none; b=DjdpTzO4djNfB6IuAqkJRD1Imo99u2ysXcmbGy6H6S1G8Cvrbo6CzZwPB0rQyFmcWvddNgmLShQuu5NIq7LmvQH831166iSXzKGc/zaGqZNqM6ATbnsQgDAo5Bjlc1Sf1FgXRBFDeW9LinDilIVNMvGBGphUjKKJrqn7hLUHBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163381; c=relaxed/simple;
	bh=BIb8PPjZHUval8yQxPaR2VI3OQirSDX4w545WCXSCig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5ztBFa/NY/Sc4eynH3ypq9n4+V0ZkWd3FXZj/GUkK5rPvrv4Vxp9Wy/b/uqTEci1C2BjFDeNRsJfx3/7q5tIf0vYgzGO8lZFBlnbAk9zFvLcCqnFTG51NCu/XugN13z0Et2obvvHSr2BiTgp8yiKy9xfrwyZET6/NQMMoiO/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=C/AInHnP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="C/AInHnP"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf5f4e82caso685305866b.1
        for <linux-hardening@vger.kernel.org>; Wed, 05 Mar 2025 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741163377; x=1741768177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iS635IvOc12Hbl5A1UFbpTyLqQYfDtGYrejudL0pBtc=;
        b=C/AInHnPu6QEjteXzTU/Y+8cXSDnlwTkiooAJDKunOxZzuyXInimEwnJpecJbpBo3o
         S0UwivWB0GwvIyxeMHaN7kHTe8v9oWO8YEWbnI+3h9H+r6sM9huilXAF30fpcyuJxNry
         vQHWkiNk5GpMBotSLwAx8VmIyzmnw31+gj2/wYmyQ9aohqYul/YubmdUtV1YULJ3ueUf
         FZSqkMhgWVa4aibkSIeJZkFHujC/3ywr1mpvpJ70ptJ9X3Voog5WLOfvXh2hdfwIEPpk
         cvKKZhVCj0ZGtNxECF8jjfftN1S7xScxZbWrwuJLw1Zf9y0aK/TKDnTgPwJSsBEVb3Ez
         mWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163377; x=1741768177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iS635IvOc12Hbl5A1UFbpTyLqQYfDtGYrejudL0pBtc=;
        b=lp+b+RhdlqduyfMeVu6LoxwXr9UGNFHRqhEP3VyZ7UHMXGWMhFSvSY78fb+0weKc9m
         3AC6IEifVpWWTCLFQ+xEsVzq+2oqyl+VIdY5mN1u7MmxHeIZNLWUdfc3YHe8aJdmFYVQ
         uT8g7h2SUkdSqPJq32h7TqB1zJGjLiK8psL6TXFienl+jtVbasBpaE1P6FsxAEJhMpH+
         peeqBNkDr29YUr+Czm6pukCsPLmkqXbnA9GfgkFZ0JGR880h06Sm9KgR1LEHrjEM6BSC
         iQk80R4ruYs1iN09PPWtkgjTZEwS3WgJXtVb6eZwkXVMVlnOhdB/kFvdSBlbvC5B1Dxg
         CBIw==
X-Forwarded-Encrypted: i=1; AJvYcCXTaweaoXsde/1QX0N0Mk8dHSZacaIv8M9l9gvOv0Zmn3iv5npuLzj2GYmKPYmm+xz9dToOLKLE8COxLCrDp9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLKdJV32u9+JOvoe9KclkcRppTd6k5uMrKEnivj2ixcDadY8G
	z4IPvPAej095OegCnFQ+MYnXSMjU+R3Ty6gbfBqmSdLJIoLzgmwp8fnDvwaNsgM=
X-Gm-Gg: ASbGncuna8y7vnj5C1hV6U5m1pN1i8Ure6XS2rGH7OZZyFDR079Z7DkTe0RCaQdacRj
	tNqtxJaP7gWM9h4uDp1u2w1Izuunqm3hTtFX7ALjfIFqzZbOp1OFkuIozam5utK3uOs7owSVNWm
	48FsmxM94PjWv9pJXhkCiNAzMp7Q1HILbW/RJZu+rG9itKFBKj2ThV6SI7Bvnx76Mj6QlvteHuv
	nNDcJoyFBlPZaxKwRQ9c5eGuMtyRdKhO2y+Dg7Wxt3HUCxpRMTSbJR+e8F9gEviVXlgBFFOGTK3
	LU1k9iofq4K1Yyh5ojtbc7rHg2j+xgThp1hELengcKHoxozgwCHJUd71ql+WIoIlosCTnpdJBH6
	K
X-Google-Smtp-Source: AGHT+IEjj5zOJcj1/OsRfe5VF46uWo7cJGLTZaHw0tlhP7T8cxub/kFHcc4MiHV1iodJ3D5MAmAOeQ==
X-Received: by 2002:a17:907:9446:b0:ac2:b73:db3d with SMTP id a640c23a62f3a-ac20da4c87fmr226467166b.4.1741163376857;
        Wed, 05 Mar 2025 00:29:36 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abfa393dd6dsm453290666b.96.2025.03.05.00.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:29:36 -0800 (PST)
Message-ID: <1975f2a1-9461-400d-8b3f-f40e8b94be80@blackwall.org>
Date: Wed, 5 Mar 2025 10:29:34 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 15/15] netfilter: nft_flow_offload: Add
 bridgeflow to nft_flow_offload_eval()
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-16-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-16-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> Edit nft_flow_offload_eval() to make it possible to handle a flowtable of
> the nft bridge family.
> 
> Use nft_flow_offload_bridge_init() to fill the flow tuples. It uses
> nft_dev_fill_bridge_path() in each direction.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 142 +++++++++++++++++++++++++++++--
>  1 file changed, 137 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

