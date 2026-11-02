Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638700;
	b=OK3eQ7deCwFGiAGnsR6OvsPvrEqz96x75BEViHw1aTix+BI6+Z6iHsyiDV6CNRi+Y4nd
	 RgFdwZjHESLR6Igrj/Dd3T64mBNPJYP41GzfGNh0233+DcrrkLdHpoOXnqBgFrcbY9j/H
	 qQoTjlAX3s6R7uUIpS2DY2m3OVtDiFQPyHSx5jbOKSTNiWn0rMc0pBNm6OsdxYzhY4yol
	 ktjkoFa4GYVVRocTwz7mbuAbvTuthNZ/BwnMEey+HlYJoIw46R1yiIEY12aMd8CzsaW7h
	 cxBzX7TEAohacGOXGtQ6x4zxyk0a7jVWgnzy68X09txCUyKDezhFqrP8iiGvK+hz11Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638700;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:CC:Date:Message-ID:In-Reply-To:
	 References:User-Agent:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=KIqsitZcMi7h2QQHA4zZ281+QxpG2+lZy3zu6UwkhTg=;
	b=Rw7QNFUdjqKs1kKsd9E0ni3NJSyaLK56X0K70CLZ/Ti/wfhYBR8VmdiIRZ6TkQFHsTpU
	 1kJzRz7GeDjVhFiQuj3ChQ9mkp9Ccx6TC8PiiohwZlY/WPiMOjJK/aXEjfxubc94k/zya
	 aGtMIck9sp1NUd4DqtVPc/CxkH3uMmNA96BBbgc9P96k/f6UdMJKQSm/580quE77ICSrM
	 ortJcSk2FwBbSBV1gkgEPwGZcNOvX/NHadmqy4cuLC3Lq+SmGK27I53xQ2ZpFPIOoJfGj
	 Eq+KKRDh74JlsutzWYI7DgM5BMJAfXDkhdDAy+lPDZ2ioETJN+k9Jzaz9iAuy+rDoVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hdcZWG8g;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375E606EE97
	for <linux-hardening@vger.kernel.org>; Mon,  2 Nov 2026 16:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9375E606EE97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hdcZWG8g
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so1538075a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 08:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638699; x=1794243499;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIqsitZcMi7h2QQHA4zZ281+QxpG2+lZy3zu6UwkhTg=;
        b=MdLCYm+EJoLjxZ/5YGbMkwfhB+yKA8kRXP/70m22DPNK5q/kl6Lu6qrQt8/ABD7Tqd
         MwKdlsSeK6aCy8POIT6A6BSGsUdRqA5xmDCmajIxsfB+JXP15lrh8odhByIOejjqw+nY
         nyoTgQAmAbTkjkLrt9bxIL9axb8Hoo0DGaktlVcHXDueB7237HZadn00yIgOsBuglFdd
         DIK0EqC+ffyMSsWSndjaFoHJJnLhbUFKCrrJ1vs1SFHbUZQ2juts+FKrWakX6wbN2fSU
         zcnYNJ/TQKpspuReryN6mAd+LGZY4oKJJLQpu6m3MvWWrqInMwZUpDuIGwzzcn3tJdPk
         IBOw==
X-Forwarded-Encrypted: i=1; AKwUvBwbfvM4BZ4m9mjL/u8yENcCC8ROzCmX2CvfsP+SLQ08mJdTUc4hgEcquwGhBDFh5NtwaMllzt/wzR6CdTwDF8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NZ4GAOpVx7Ivw3OaOXuTiwf1jDyD0u3cuNSM37jpWspRyNg4E
	pgSa6GAH7v7prxfQC8QRfRr26TvMdIK1m+3lCT3ZEIi9y+5SNAtmXmI8zuJh9z0V88ABu5HjPeP
	1VeiFbIxhu8zlQgzx5ew21Ni0JQv7VNi4Q2PEgQTp+jVGhptX24EyCmidj7wwvBLEq8T6n6gYBQ
	/1XhVzW2VwwOF0N7bBQ0zW5G1J20xAwoDQaU2W4IgzvxI3ubA+tBwTIHr7KVZyVzgTubK9wja7q
	wIYsFavPHr0+fdPmz3TcTRZ7yc=
X-Gm-Gg: AYBFou0hcKmOSLdJb5HtLfl2V0KmB0JjM7y3uheww93HDAj36XL7T8zCBA4NlmH9T1J
	h0HcSfXR+RGiRX+GaHTa84Bn098u6LCMWPEM+fZvg9hLt32DhyNPD8cZn7YG4QARFR38nehfDw/
	ksq7k9qKdY+bBm7SRhr86eMT2CWCUPvrwnkV0z8MD8LFHIHGkysXb29F2MhKLgq/6dN8NEG8Rp5
	R9XMgLv+sDZLAXw1C8p67QuHxPXhULvUimSV9F+Blog71uQgIlUcrWcfrh+2pdbZIbYs6+b1XT6
	FNtF84a0guz9XKFXZVurWvebGprqjtiM+bFiA5HxVqu4F3D8NlZfsw5kjeqlJAtaWS4p3XXoMhZ
	50UxeoOJEVMy9uhmaXF0I9/2YNtMG/p4mxfxu6GrkoJl1I9vZdI3jaIAEktrJu888vepYHcg2DR
	ryyShSq/EjUtsiU9GGNkAKcp+mvT5C7kTvjlA1OX4=
X-Received: by 2002:a17:90b:1c87:b0:3a8:195f:186 with SMTP id 98e67ed59e1d1-3ae897ee656mr7681071a91.42.1793638698825;
        Mon, 02 Nov 2026 08:58:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b07c4d7c5fsm9871a91.0.2026.11.02.08.58.18
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:58:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-843c6807307so4180749a34.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793638697; x=1794243497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIqsitZcMi7h2QQHA4zZ281+QxpG2+lZy3zu6UwkhTg=;
        b=hdcZWG8gMbeB5TX0YsX6HZFukc+i7ihXfyZHSmZH3/RxNQNVKw64zlS9owFM8qFicM
         A03Lfv/TWoUpsXa+Ha/dfo4/fDXNLYlZ+KYXcSsh9GcLPiMXj7ba0WLRnD1CgKpaGk81
         ShBtIjONXTBgYLFiOJ3JvdWFzCXvRcEhXg4qk=
X-Forwarded-Encrypted: i=1; AKwUvBw69LaMWTP5bvdXLlqb49ztFyHUSYM4UimcFc03kd2q0UlOk0lsa7SFTWP9l6mI20Qy28EDMxEBzcuZEOJFFnY=@vger.kernel.org
X-Received: by 2002:a05:6830:2e04:b0:84b:c230:c2c1 with SMTP id 46e09a7af769-85d36400d05mr10579871a34.18.1793638697457;
        Mon, 02 Nov 2026 08:58:17 -0800 (PST)
X-Received: by 2002:a05:6830:2e04:b0:84b:c230:c2c1 with SMTP id 46e09a7af769-85d36400d05mr10579847a34.18.1793638696985;
        Mon, 02 Nov 2026 08:58:16 -0800 (PST)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354985cdsm9955316a34.10.2026.11.02.08.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:58:16 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Neal Gompa <neal@gompa.dev>, <michael.reeves077@gmail.com>
CC: "Pieter-Paul Giesberts" <pieterpg@broadcom.com>, "Franky Lin (Zhenhui)" <frankyl@broadcom.com>, Mathy Vanhoef <vanhoefm@gmail.com>, Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <asahi@lists.linux.dev>, Hector Martin <marcan@marcan.st>, Daniel Berlin <dberlin@dberlin.org>, Janne Grunau <j@jannau.net>, <linux-kernel@vger.kernel.org>, Hante Meuleman <meuleman@broadcom.com>, <linux-hardening@vger.kernel.org>
Date: Mon, 02 Nov 2026 17:58:11 +0100
Message-ID: <1a19d3270b8.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAEg-Je918POdPr-=6Dzpdkx_i+Hv4wxv5-8A3MUDEqC8SA59NA@mail.gmail.com>
References: <20260925-brcm4388-submit-v1-0-b5cbc2cde2fb@gmail.com>
 <CAEg-Je918POdPr-=6Dzpdkx_i+Hv4wxv5-8A3MUDEqC8SA59NA@mail.gmail.com>
User-Agent: AquaMail/2.8.1 (build: 200801029)
Subject: Re: [PATCH 00/13] wifi: brcmfmac: Add BCM4388 support
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 2 november 2026 01:43:07 schreef Neal Gompa <neal@gompa.dev>:

> On Fri, Sep 25, 2026 at 9:49 AM Michael Reeves via B4 Relay
> <devnull+michael.reeves077.gmail.com@kernel.org> wrote:
>>
>> The Broadcom BCM4388 chipset requires new PCIe initialization and
>> firmware interfaces. Add support for these interfaces to brcmfmac to
>> enable basic station operation.
>>
>> This series adds:
>> - Signed firmware loading and mailbox transport
>> - Fixes for chip identification and firmware capability matching
>> - Versioned scan and join requests, and extended PMK payloads
>> - Updated event mask handling
>>
>> These changes include work by Hector Martin and Daniel Berlin from Asahi
>> Linux, refactored where needed for upstream inclusion.
>>
>> The series provides basic station support only. 6 GHz support is planned
>> for a follow-up patchset after this lands. The driver retains legacy
>> interfaces for older firmware.
>>
>> Tested on an Apple M3 MacBook Air (J613):
>> - Device boot and network scanning
>> - 5 GHz WPA2-PSK association and DHCP
>> - Bidirectional TCP traffic
>>
>> Testing required separate Apple PCIe and devicetree patches, as well as
>> Janne Grunau's port-authorization fix [1].
>>
>> [1] 
>> https://lore.kernel.org/linux-wireless/20260915-brcmfmac-4way-handshake-offload-authenticated-event-v2-1-fbb9cc7ac177@jannau.net/
>>
>> ---
>> Daniel Berlin (1):
>> wifi: brcmfmac: Support versioned scan parameter layouts
>>
>> Hector Martin (6):
>> wifi: brcmfmac: Support newer PCIe core startup and interrupts
>> wifi: brcmfmac: Negotiate PCIe mailbox transport with firmware
>> wifi: brcmfmac: Load signed PCIe firmware images
>> wifi: brcmfmac: Accept newer BSS information versions
>> wifi: brcmfmac: Support versioned join requests
>> wifi: brcmfmac: Add BCM4388 support
>>
>> Michael Reeves (6):
>> wifi: brcmfmac: pcie: Report the detected chip ID to the bus
>> wifi: brcmfmac: Match complete firmware capability names
>> wifi: brcmfmac: Fall back to RSSI-only default join preferences
>> wifi: brcmfmac: Use event_msgs_ext for event masks
>> wifi: brcmfmac: Handle larger firmware band lists
>> wifi: brcmfmac: Handle extended PMK command payloads
>>
>> .../wireless/broadcom/brcm80211/brcmfmac/Makefile  |   1 +
>> .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |   9 +
>> .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 368 +++++++-------
>> .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |  36 +-
>> .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  27 +-
>> .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   5 +-
>> .../wireless/broadcom/brcm80211/brcmfmac/core.h    |  18 +
>> .../wireless/broadcom/brcm80211/brcmfmac/feature.c | 124 ++++-
>> .../wireless/broadcom/brcm80211/brcmfmac/feature.h |   2 +
>> .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    | 130 ++++-
>> .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    |   1 +
>> .../broadcom/brcm80211/brcmfmac/fwil_types.h       | 141 +++++-
>> .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  |  65 ++-
>> .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.h  |   9 +-
>> .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 560 +++++++++++++++++----
>> .../broadcom/brcm80211/brcmfmac/scan_param.c       | 416 +++++++++++++++
>> .../broadcom/brcm80211/brcmfmac/scan_param.h       |  13 +
>> .../broadcom/brcm80211/include/brcm_hw_ids.h       |   2 +
>> .../broadcom/brcm80211/include/chipcommon.h        |   5 +
>> 19 files changed, 1593 insertions(+), 339 deletions(-)
>> ---
>> base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
>> change-id: 20260925-brcm4388-submit-5cb8d3e6d6a5
>
> Works for me and looks good.

So what does "Works for me" mean here. Did you verify it is working on some 
hardware you have? If so, please share the info.

Regards,
Arend


