Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641FE1F5836
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162899; cv=none; b=QaraKYhfgSt2NDGfQpS9FZw0CdtB9W6mLB7Y1GODpfJMrUd9sEikZ2LYuH7rGgJG555DkX7eMvqO2cnX10UQUdFSgQDBPh61SYxBVF5vJVr4bR7PPhKJKf5dAXZUZsoDyMDvcC1Y0r2EUD/BumPpl50b0fcrLhvtE1mmI6OcT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162899; c=relaxed/simple;
	bh=Dd3fU7x3Zyy9J91IPT2gBtr3RmiUZhQvAeaOmlAbIPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BC5aSKoJy8cKh2xdLgWb+z5yTK65w3txHlOakHfo4as8kNPLZWbRUHd4TUJYYE0onreBNKRhCQiF3f9BVTHa80oi2QOpLQeVwpFyqkrzuCqhTnkjeA77Vmh46WjYafFmGQgKKfOiHY3ddBeoLBs1/RPqjACb96dafpr7mEE9JfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=A2bhTYH2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="A2bhTYH2"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf45d8db04so661976466b.1
        for <linux-hardening@vger.kernel.org>; Wed, 05 Mar 2025 00:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162896; x=1741767696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsv6iruxF/55s5GG7wPPBagKb4juSNlpcghKgAFq1qg=;
        b=A2bhTYH2IUKPMamHYkFV5kaQY8j11XM1Rkzkh8OksbViihKIHdIyYaOl68RIpO6mJ9
         0hS5ZGLixOaBzMhOI+yG6WhYFTQ4GvqL9Nc/G3etuoWG7vQVXGzS+zuwOJPAXifC/UTl
         XF/kDOlaCo9md4uupo/S3HQC0igucI4fKqBDm52qzqnPbGZwkujc/SsZj7uw3a/yqdsK
         R2R5d+LjtiqUYkiv8EgQiG4rLJm21gZmemC1eIyLxXGlwhxKO3jmhAf8UIXj0PwCpkfj
         sGTOddwdQTN5kI4jOrmHFMWg2zZHCLBhrGM/Fzp0lRv+M3RkPsvVT00gLuCjUT+aoHAy
         Qp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162896; x=1741767696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsv6iruxF/55s5GG7wPPBagKb4juSNlpcghKgAFq1qg=;
        b=ay/xac3Qpw+LLZgfo3/Kd/5AVZ2n/lyCzETDeiO/IkZFENzyUswHICCMjGpDTRxd/X
         /Hq1oU/7IH2M+Xgk4XwhnoR7qDXH56FOi/23+2dlLxIwD9K/3dVuX3j+bLL8rSlLf6SZ
         z6PdIBPRuqWZZH5tMuaH3TrwEdAXuY+oBbQaxwl5eCuW2GxC/+oDWmeaueVrMqAqrIHD
         Ud0+uWQbmAirXe2eZhD2M/uQ/lL/YXkvoV0U/TAxQKvrlGF1fPSj7Plr/bFl2mcSeDwV
         IiE52DtmSJoKDzWJtF+1Mt6BO8mkGzNAgVu+27rPPli/OLVEu9Hu0fugVAKExNgqgDfA
         S3wg==
X-Forwarded-Encrypted: i=1; AJvYcCUzoo0MUYZkaM6zZTYYegBs5FHX8PVTU5kxFHa0aUZJMzW501dRhpiSmcGEPQk2aM7BGAhxA+8YKCOga/Tsk0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04dTFxtKyKv3q1qd8w1fUYXrlDcjFRrzDXRtFd97GUEQI+ZWg
	YXGj/m1I+48j4MASDlcR61N1QcGcAf3/ppvRyDk9IPv9v1OGXy2IOZoscn5uSxE=
X-Gm-Gg: ASbGncvW5dd49uLR21ujJnluxINNCfHUvWIgjI7WaCAON14Q8EoWwtk4oNblfkkwwWY
	jHwaa/D/r1pB66laemL8/yWGM39/xJylw7csghEf6bwpaRfcwXmeCJkgPRzZWwrnZ/bI3D7wHyh
	Qz2D3Up8zIoI0w1Ny27PZuNpA+i/7LEyfH7elJI50WVyAB6Grcto6WEwFsAildvQ5rKkEiZ9/ql
	SAT1KD68VCZfCRxDJV63ZRHG0o1F1xN317fQ0Ty3+mTREj6WU/0mc/rGIF4f/m/JbUr9+74oWzc
	MBVfsKGI97ISDsNYNYvQ4g0Mzvb1Y57liIXJrSBwpe4mK2H/Q11eSx/6NF+tweJRZ1Wg4WbXmh8
	y
X-Google-Smtp-Source: AGHT+IGaoXnq3lSxzaaUwAuVfK+jenlYaXFrv+TPSgSHSnmbmoUQLeCI462sahYSphebEzq/qYnUHQ==
X-Received: by 2002:a17:907:7f0b:b0:ac1:fb60:2269 with SMTP id a640c23a62f3a-ac20d925048mr217259766b.27.1741162895402;
        Wed, 05 Mar 2025 00:21:35 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf58804b49sm693744066b.26.2025.03.05.00.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:21:34 -0800 (PST)
Message-ID: <b3b5418c-65d5-48bf-8868-2d9abcb4f758@blackwall.org>
Date: Wed, 5 Mar 2025 10:21:33 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 01/15] net: pppoe: avoid zero-length arrays in
 struct pppoe_hdr
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
 <20250228201533.23836-2-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> Jakub Kicinski suggested following patch:
> 
> W=1 C=1 GCC build gives us:
> 
> net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
> ../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
> ../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
> 153:29: warning: array of flexible structures
> 
> It doesn't like that hdr has a zero-length array which overlaps proto.
> The kernel code doesn't currently need those arrays.
> 
> PPPoE connection is functional after applying this patch.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  drivers/net/ppp/pppoe.c       | 2 +-
>  include/uapi/linux/if_pppox.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

