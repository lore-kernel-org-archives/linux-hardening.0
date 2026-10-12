Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB912428470
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831778; cv=none; b=qhTQ5cDDBkEvC537AtPYz5Hze/Kl8mSoggSVGTnuJbU4i+Fhrsw+sLhK6zVn/tDMFAPPmj8nyfzAJpOCpUDDnn3Wy6PnDyfOpX4kKd06FubfIaT8TxuhMZLCy1mnnfD6qFvqnQHf8ZHYF4PWKjWUiKq0dardyDV4rBkGEZtxBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831778; c=relaxed/simple;
	bh=BlAW2s3WJD+TEcvpjdpLLq/egK9JpkVxEaygxyYoXWc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sey4t5KXq66eJ9eTkLQwrLJ+c64UF8pbRRy/cuSPVRKzQMdJxq9djQHyeJ0mr4qfbcNzeqQTNM3VtgNx/9m0bubpNhy+G4j8PFy9572JM2N1vew+f/6FFTMp5gIFyQ/nWtoqwQFZ0C49WG3HfwWTDCtNZGZh4YthvmdGe4r8J8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=JyqxcYkM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="JyqxcYkM"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5352a876d5aso29675701cf.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791831776; x=1792436576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=laFs7jlIkL/wK8Exmb0UUuiq4aC/G+SY8DOFmho4Nis=;
        b=JyqxcYkMEhPPd1CSNODJ/jyyrnpymJCtRpdQCMEZ3yphQItkCsPm12bs43Icvu4Z2g
         Iqyk4/KiB68Drk91Zu396UTq+Py+IsMtKbGPeoRcivVBpXlEYDyEonw+32HPzig8b4Yi
         qGWLfd3sCRABPzv9807cyBRvj7cRFc1Qe0EwgcpHdFiEB4bgMEHz6/m7p9DfcEjSwlwo
         PpZkfI/0EIbriGH9jWsXFaMqOvRxNGWvBKosGJ+VRvlUMTuyMeciExpxT4tWE9wY9XFh
         6ORveyNMq195sFlGbCHd1Bt4p5OtIEPGbG/O6CvNrSUC26SdiEDWmN1p8zHkk5j4i33T
         tbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831776; x=1792436576;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laFs7jlIkL/wK8Exmb0UUuiq4aC/G+SY8DOFmho4Nis=;
        b=WnyBI0YF+1Rsyn5oIMDD1K+USgnRZjLq+7TWFDSDe+KiE+nJw0roioGLM8c0nzHPJv
         bhIMaCJ0CQH+CQs47Guf7J9YDVnzILmcM+uN/l1sXt6n+YjRjlrlQp0baOZfv7UYRUtw
         iH/al9PWopCxWLbpanXB8tyVHEL55Ii4yDkqVeJX9fUGMuic/0HKQ+nptIdyde/TjR3t
         BXW3+TX13Lv7NML/XMv7iFffdOyNUaGjYjy6NxUj/o/d6prYJCPuhckISCK4UG3LRWdb
         jgni4yN0Jo41nF8m+6KC3rUBkeL4NdoAKJkFwFWWZc9QfEob7abc09njmGhn7QDUVMs/
         BkPg==
X-Forwarded-Encrypted: i=1; AKwUvBw0M6wCNikCHwuE643H9edlJGJBS7rRtOYlg/V5Q/heyRPlVFDgyPFButM2LY9SOp54v6S9JCuiYSoCLayrS4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJe16LbBxFrqXtAUNVkbAOSpxNiG/iumBz1dpK+QOOf4U3oZYx7
	jeOJLvDpdoyxmGeNZO2jqcbaBxZIsdf6J/zDCrFkwrzldvJg2XR3z+o66HdVk9RvKpg=
X-Gm-Gg: AYBFou2ayIfORxhqVXuPdio72s0iEsJmBT15bnZx9l+00CcJ9bVX66bVqjy0stP3/Op
	taSk7Hstlp45UZP9IZ8LiZYzhzFPiKeQUrsa85r5aAp6hHU5d0mwuo/sL8lYVTVzSy38OexVQM9
	N1nckWOICRt+PfeIWANdUeyT01tj7MH6lDSQTqPAKqv+P2S34MmzXQagSQv1IYboSHDr9M5mQ0P
	g5CSCmFb3iYZffFywwgYXyvlfYLG2ABUf7n465e1nU8Bd12exFl8CP4xsb7tvb2QcC/Ka05QhlC
	K/5kTpAJm+/g9xa4hMvXYxbgW0odonMiGVYE9SRH20hS5pOP5/jwVsIoWZ4ozDuFtE3pjF/GBP1
	ob7JVkOvFK65gIVI7FWxv9rfNyEa81roJuXIXBh6wefjcrZ4RrRxca2O1V2DLcIvtlWJDSjySm0
	83gkchHJcTMegDnXJZy5TaR6dnOH1nQv4cMM8961dnc9jMk4/xjLE/09wLX7PhG2/0HScDQE4=
X-Received: by 2002:a05:622a:8cf:b0:533:370c:7600 with SMTP id d75a77b69052e-5359fac22demr153697041cf.27.1791831775276;
        Mon, 12 Oct 2026 12:02:55 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b9783c8e5sm5196456d6.1.2026.10.12.12.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 12:02:54 -0700 (PDT)
Message-ID: <71854ab7-107a-4218-ad37-14c6c6fe6bac@riscstar.com>
Date: Mon, 12 Oct 2026 14:02:52 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] clk: toshiba: introduce a TC9564 SoC clock driver
From: Alex Elder <elder@riscstar.com>
To: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org
Cc: abelvesa@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 danielt@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Brian Masney <masneyb@kernel.org>,
 Daniel Thompson <daniel@riscstar.com>
References: <20261012152408.3729237-1-elder@riscstar.com>
 <20261012152408.3729237-3-elder@riscstar.com>
Content-Language: en-US
In-Reply-To: <20261012152408.3729237-3-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 10:24 AM, Alex Elder wrote:
> +static int tc9564_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tc9564_clocks *clocks;
> +	struct clk *clk;
> +
> +	if (!dev_of_node(dev))
> +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
> +
> +	clk = devm_clk_get(dev, NULL);

This should be devm_clk_get_enabled().

(It still works this way, given it's an always-on fixed clock.)

					-Alex

> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "failed to get input clock\n");
> +
> +	clocks = tc9564_clk_init(dev);
> +	if (IS_ERR(clocks))
> +		return dev_err_probe(dev, PTR_ERR(clocks),
> +				     "failed to initialize clocks\n");
> +
> +	/* Force all clocks to be initially disabled */
> +	tc9564_clock_disable_all(clocks);
> +
> +	platform_set_drvdata(pdev, clocks);
> +
> +	return 0;
> +}

