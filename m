Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714367;
	b=Ul3UbUBdT1lfYlbTJw+dHQHjTKFXo1uDWkLXdhh16gUzXzC+PJJElqW58uT7c/ib98bi
	 Y5sRtSk0GWvTANE0xNiopwMqojZ9oyBUAxPOYONnaQ9mb9TsdUvNNI4rUia5SGdkfggcY
	 mpuZywwMeyibJICzhOoF2/xg//STOjUcoSuZbtVh/IYxvNRHfUncgiTD54gzV/SEb+YAd
	 aoGseFVblTZQtk1BzTetAohXD+h+VN7Em9G9x0UMSpH+vyyo4E4qSfP4zOdGL2gKEL3r/
	 z5sSrbBlWHU53WPTVmt0jtwLbLykSRK+QeNeG/i1fL9lGSC5b0Of2pUHbfTGlrLthwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714367;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ObP2EjY6D+HzwangbrGAF+EH007820Bo/Jvo+O4ZYyA=;
	b=E4xSSrSDgJe4kFCukk8uXzWvwLxDg1RJjqOn/wzfCQWLFcXCWjADHDoXZTCQlHUmWJad
	 2E0kwMKgktiMYh0c1B+sw1MxlKlxgsyQP+c0uVUNjSZK9uE9LBNXqAjTlOrx+EbsInEmC
	 vnJtGNdwwArRJUADQTrkdMIPmx29fUSfBPyEdIoxssFPPz87YgSMe1y6gLDhE5M6aK3o8
	 I7gIG0Ev1oSvsLrsCkQ9lxnVLXZIhwovymPhzm1K736k0yUStZviY+PJs8wm01iikxxrq
	 Kb6mwmtksn5/sRYHHy+z/nyJ8/PuzLXUNR5uVn7xTZ8Xt/tD62Ub4llWAR4208o9FDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Bbzlozea;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44862606D803
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44862606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Bbzlozea
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so484782a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714367; x=1794319167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ObP2EjY6D+HzwangbrGAF+EH007820Bo/Jvo+O4ZYyA=;
        b=v04Nrs7seUPf8Bb0Yq3g7fSqDHLS1gyS6hQfWEk8vBbpTmDMDzctu2d60JIlxSBaRY
         2Avabgmc2BiduWhcQJ0OigNDutCf3RyZLFV1i3m1QEQBk1qVQxEgGpSw8oSTXdYiDgjQ
         iiMaVlrAFG+ViQnQ1ksrEFqnutD/ZF0bhqNfJ2wm3aOy0yrMlBZm7qZ1ztKCrwkO/Dp0
         V6pGDMHreeVFg3llRIaQS5F4HeXkKeeMyptFjVCMTMc5ad/Min7KH/7P2kreaXOB59Nm
         F7XCgn2GPWNGfXgexIYb7a9YrhKb907Rzxs0C5RibyV6f/d2UacA5HuIvBIqJunItCbG
         9VLA==
X-Forwarded-Encrypted: i=1; AKwUvBzEZP/m8wU7RPVg6UddIYtNsTk5xqzQbWJUMERTakc11R4P+69gpYnlKD7NgNqeQnYNzhd8cC3kelf1HzIil50=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y5bpMWpc3lMR1Ro2XLm2R+SMLuE8AiY7sUYg0ni5IsqakVZxq
	zpSEwbPlj0cka1ARZHBYl3lvKomrBUjD00Rsfap3LaJe/j8+MBSdfAska301qCszpDDQA6cidX6
	RREDUV67x0OAZ3ckUfQ9PciFitUylp9v1/k3pCVKbnyqvVk8BiXgyto7xnfYi4hzqjP9mlkTJRx
	8Ao3NuCzPNwLHoiZiAAUpqyrfwNSIJKIt4y4VYlLqAgH8IQR15SZMtOCg/o987uZb8A/HkNBq8v
	ZKwve5cAZHN/eaamW3KIKuy6Kntvw==
X-Gm-Gg: AYBFou1DrmlBCDzs4zvIYmQAo+gZ0LWXEww7sriAeqEIJGSu0S7MMqOQ68gtGooJW5J
	gOgx18lKpsxHpHvwt3FyGnxLmpu1k944MARDEqMg2vz2XbLGS5Bc5WHb9yaMTrlwap8wgPAGmWn
	xWDl3qpoY5zdtrwglwbhrenGvvHQy7eAkPhHL1sZzI0HdkQfq3xhCqOk7MU3IDVVOAKUgyYozr2
	fk5niW8xwrxC5slnJbb7nrwg1gDBxEp0/CGQs46l4zbijuEl6ANvfwwkXMrKhsnDxWBLbaLop0J
	eaIr+0uaqFxa6KTAx88owd4j3OHhw9DBsP7tE+p9rByhzwc9BZDueoB0ZKLPPSDwpF0xC+a2qrc
	lZUieRXnjQEGUMlPyDxtOy/eIDViT2RjUpvozSA6f+BkU4ceFTr4sV5wFdMEnQPKSBys7gwRTAC
	RVgkPXXh9wEog1H31JGk6uKV4QDQZcl5DRXqWIHPo=
X-Received: by 2002:a17:90b:4b8f:b0:3ac:b6eb:e0de with SMTP id 98e67ed59e1d1-3ae8955a23amr6736852a91.4.1793714366424;
        Tue, 03 Nov 2026 05:59:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b07c8297absm1936387a91.4.2026.11.03.05.59.25
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3425098ae4bso1030821eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714364; x=1794319164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObP2EjY6D+HzwangbrGAF+EH007820Bo/Jvo+O4ZYyA=;
        b=BbzlozeazxgHj4zb5a8zE5W7BSXJ6Jh1rNN42aM3NvANfqSuXkjtgWvNK0iGxc2s55
         hPXFnULX3czIuObzc1btBzp0vw7fMoXLtMRAGpyaz3121uNNhMPV+H1zvYpF2pU5B9IK
         yojvDOWB6l3wOAccl8T+Z/gDDMoRkBw/3yqcU=
X-Forwarded-Encrypted: i=1; AKwUvBzU04AayfLngX8L9EiC4RXpbrRfVvfKBt/A8mUsiGijiGRbbb7gz7jtaDT69i/CxA77Hdlt1yWWDXzwW+XFPkI=@vger.kernel.org
X-Received: by 2002:a05:7022:f90d:b0:151:7831:e403 with SMTP id a92af1059eb24-1ac5b027fbfmr16236311c88.13.1793714364492;
        Tue, 03 Nov 2026 05:59:24 -0800 (PST)
X-Received: by 2002:a05:7022:f90d:b0:151:7831:e403 with SMTP id a92af1059eb24-1ac5b027fbfmr16236255c88.13.1793714363382;
        Tue, 03 Nov 2026 05:59:23 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:22 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Michael Reeves <michael.reeves077@gmail.com>
Cc: Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	"Franky Lin (Zhenhui)" <frankyl@broadcom.com>,
	Mathy Vanhoef <vanhoefm@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	asahi@lists.linux.dev,
	Hector Martin <marcan@marcan.st>,
	Daniel Berlin <dberlin@dberlin.org>,
	Janne Grunau <j@jannau.net>,
	linux-kernel@vger.kernel.org,
	Hante Meuleman <meuleman@broadcom.com>,
	linux-hardening@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 08/13] wifi: brcmfmac: Handle larger firmware band lists
Date: Tue,  3 Nov 2026 14:58:48 +0100
Message-ID: <20261103135856.3676311-5-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-8-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-8-b5cbc2cde2fb@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, 25 Sep 2026 23:43:43 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>
> Some firmware returns more than two entries from BRCMF_C_GET_BANDLIST.
> The fixed two-band response buffer cannot accommodate these lists.
>
> Use a larger bounded buffer and register only the 2.4 GHz and 5 GHz
> bands handled by this driver path. Ignore duplicate or unknown entries
> so they do not prevent wiphy setup. Skip unsupported bands in chanspec
> lists and scan results before decoding channels.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 48 +++++++++++++++++++---
>  1 file changed, 43 insertions(+), 5 deletions(-)
