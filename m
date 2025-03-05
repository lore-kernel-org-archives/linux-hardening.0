Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747401DE8A5
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162825; cv=none; b=SVZA/oDA8daLSAFfz2Qs36AvX8dskANeFHSFFWvbGrHmgh5mn6jUcur40yP2HCL1FAwcU3/RT110JxDfdAOZLEz8OIs5BBIg+xgTo0YD77okwAfGwtZdnPCdyKzvmCTpmyNzykGFPxYFEf4GrDP60u1Cz879gSX1TXJCZMXQ7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162825; c=relaxed/simple;
	bh=RWpWc+faJ0YZsTPx4jkXwG1vJYFHTnCeCj6HQ2ZWZ8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiVO7ONyc+vniUsl668B534jSRB1+Ul385S0NgsBvdJMIiJoXObW40ONaK6E2ap7rIkpj7fycKzsCZXrGaYsvwM7O/pV1ehR2hWaK2fsy/xZZbOqgoS0Vz6BactflOjJGrOGOytvcIYzYoILFlWU15UxsisO7i3WjsBi1F07dco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=03cl7met; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="03cl7met"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac21c5d0ea0so19494066b.2
        for <linux-hardening@vger.kernel.org>; Wed, 05 Mar 2025 00:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162821; x=1741767621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZ9TMmWBCnKwhuUOANBJp50uacRGJFZ/d6Ba0SS8K6o=;
        b=03cl7metXI1cLSykSQ15A0v9urzKwbn0ZkT+OxAUedRRVCcXmLO4k/5QngaDzqWWxx
         OJpFu0+eWvnv/Sj3U1pIo1XkyZXjKxeLn2K11hS2ZyZmSACwCW1dxHknTMgct0ASxAP8
         svykkAMIMCcArfI0VNMDN+dnaBE7rjvYnER16lHjGb/pweLNbHe/U0rLhR3vVOl3coRw
         HKggazQcB8fgfDAp9j0I1qh9v9+BNbiTaL7o4dLv0klNKODMsAqt1/uWNoGvtwMIyplc
         2WhF0vJI9xcORt0EiyhdFVep21WwHSiVHd8kw4DOsRavKYAhBZauJ/MB/Uf2vvVnmJ+1
         Hnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162821; x=1741767621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ9TMmWBCnKwhuUOANBJp50uacRGJFZ/d6Ba0SS8K6o=;
        b=FWA5t0iKeOXWPc4CWcaah/CsKkZddMxcc5lkROecyXszPXCudF9cvV+OiFc6ALWc9/
         kZW7JdnMAxuLNW82hM1qsPTS9l3OCCb5kNox+r+Zd/C03CWBCQqrd+G3USyVtZCjx5Iv
         9Ms3uSlzrJSmf1m0255gVzBHWDt5FI3yzLZrxACBS4dYCr3QDGdiUiJ3h3MGkBaJD5Y1
         XrDgF9Bgf90fKu+UoL5ZELthHLHBz4jYsG39P1MKoMThZDukD2uxr8r2ANbaCB+OeIKB
         X1CIrl/xo5YyiY+A7iFH0LnC3+PbRAMiBEsG3Fc+zsMsta2jZVTBohIRizqL0HYjcjWB
         PWdw==
X-Forwarded-Encrypted: i=1; AJvYcCUBrxroC8ddzWsPE42IloKWB9mdvTwtkPg7WofbsVfqURsf/+WPDZueB3YAgKomBQ7vxgkkN7uT46+KsV5JFmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybq5pOLSNCFYqRQ94cmCJjk0ua5mlb4chR7CobO6VKaTBrXbRo
	Q6/kL+L4O1ejESTByCrmWwdpQBXoBhS572aD1ZzaSzSn5/uiiQJ4n+87tz6WClw=
X-Gm-Gg: ASbGncvGpdFck6+BoFYd6YGfArgf25HHrwewHSr0E41+NZvGMnCNnYnvlyTTCoUyi0w
	1HUnBBMdvBEWD0sf1axSppssv/zedMgXqImqgA4/9NghUIEcZVZpNUAv9fOoW5+FVxa11f1M91m
	UeLZ3ux3j4aTFRdlVc6F5B8V/ubDbPUgg//wHO7s9SzbbG8YbV4wbPhphSayPhRT652bB3AX+9s
	hKTtK9O33J0ulTmkr1s00B6Le2bYSuEdftNlGCDS3rwM9vBSh829nGEZg6Wr2/5QMfyanx2Qz5e
	Qu9ctzQ6JhbDpTFZ+QyxHjhKLmt7emXFxh6OMoyLxqEpuBGqFc9AznJFjRHN19Z3AkLnFslTsBP
	d
X-Google-Smtp-Source: AGHT+IG3uX4osOFdkeIE8BVoOkaHQ2eM06ismAlJEsM6OrJRVb5spjiMCAH7SqlSZ6VKBFc01zjVCQ==
X-Received: by 2002:a05:6402:2714:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5e59f47ced8mr4078134a12.24.1741162821234;
        Wed, 05 Mar 2025 00:20:21 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3f3bbfb3sm845989066b.77.2025.03.05.00.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:20:20 -0800 (PST)
Message-ID: <2690fc33-0646-4aff-aacf-2760706139e1@blackwall.org>
Date: Wed, 5 Mar 2025 10:20:18 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 04/15] netfilter: bridge: Add conntrack double
 vlan and pppoe
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
 <20250228201533.23836-5-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-5-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets that are passing a bridge.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/netfilter/nf_conntrack_bridge.c | 83 ++++++++++++++++++----
>  1 file changed, 71 insertions(+), 12 deletions(-)
>

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

