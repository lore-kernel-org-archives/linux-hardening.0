Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0430E0E9
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496864; cv=none; b=Rgpvg49f06L+4uj6MPAdkSn8aiTRpn1OIM1214YbQMDyk2PnTlYuWzQoixzgF2sIhe4XQ08NmGqUloaRMV+6jRhFoOyfZbr4iAMrY/FT2nNdf3kVjzqvUY5AzmFh6Lr3un0En/wX/u4IJxywADRFD2RbFy+zHTli5yP1aAKUjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496864; c=relaxed/simple;
	bh=ee5d/mCDomKopEZqYC6zk/SC4+1mGi1VGHehStvSk1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpms8PP0FT+eJJC5q2YDwKIhhhsiPu0K31zPF1F9vzPd+97aDGTt7xRRCX2nzr41Hr6LrL/S2VqYz/51hM1VHVrtV2/Sbh22pLhqkCnuIwOWKj9J6puNx89ve+2552MVYWdXO/1exeUzZa+WEpCAcPF1/v+AwGln95C1juhWlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+DDI8vv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+DDI8vv"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362507f396so819494f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 02:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771496861; x=1772101661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNZVSXjVxH1eQkOT7lQSAOIyjM/HYvFDSZC+egPazHI=;
        b=J+DDI8vvwoaJCOtowrFNWR/XWLC3IcJAs7QYeQgKp9WKRdhFL3jDJg/sf15DNLj5IP
         81CPtCtPCkwX13goFk+DGMHv+iBcuaqts4I9XNpmacs/psIZSFZlsyfynwkFY5yOnsmH
         ++buddodkiuptuhn7WjI6DpDquJdeefSWRArHpM0rp8o3Doc6LxB6Cg6E5Cs6BEXLSV7
         YG/tXORhZk/ZEeiq5AQMfuF3ZEHInmJ6TMFdv89Hy8GHdwZRgR40uDP0VU6ATNnHC3ld
         aNW7zAOG4K9/5gHWcba4+E2al4TjWR2f2jWxvWsof/A6s1kY1hqxbd5RBrl2r0OJv14k
         zgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771496861; x=1772101661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNZVSXjVxH1eQkOT7lQSAOIyjM/HYvFDSZC+egPazHI=;
        b=rF6XmFnZ/8djaOAlOK4yXKRWIWPT16yzFMtHXg2Qv+xFgPYr8tAhjTRcolgVyS12Zl
         ruz4dazuw2o+r5RhCWdUzWrnJ+8r2vHX/uLZlcUNVAq/hsrWRQZCBHdPPxcj5VLeV8s6
         4jWMKXN2X1Jp56IruU4kGVl52CkleiYZ3MxCL+u+7MSGlTXJFI+/Dpq55v7W8STS0fac
         K/mvwf2LYqFmmekPGsRGO7qy50DJmAFOYixCc0QFnP5spRT2RUled8sIs0zfOjsNCwrq
         lWGICHEXv2o1qJRu2MiNlZPLepweRkpXmc4+9T+CXT8uG8r+e9I6fGGTNhlb6iMPsBlo
         j6LA==
X-Forwarded-Encrypted: i=1; AJvYcCUN6CWbHtFO0gdaMzE+YpJnONSj0sSlkNCcXhAYqfcQ80AxBwTkhtB4qexG2HDOHU5ocil6SRJNAH4MtCrCpDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRD+baVfFiXA9sbH1YPQXpuvEzc8+LC0Tu0hvZr3p5QSZn0NAV
	+4MSATW4qFwwlvWintmRr5i3sqHv39K0Wi+1aeYLLRED2YxuBbSblz/8ACXhKilAJhmEgyPNTCT
	vWQOBf/4=
X-Gm-Gg: AZuq6aJbrvP6wPO1i7bm38rYctQA/ZwL/88cC9d+yA9zse3gykHtcwi1yD2lxaEPLmN
	XTEotbfuNQzE1qoULE2pPYGtqCtovbb9Xi7jxsKNW+cFnlWEZnXscY+mahb0NTHY/x4755NAtTe
	oQkYaaUX9VkiImQ2a3zAREhxQNVv2jY16IEpS9GVXp8yKIWb9LphwleUI9cVb/g0xx7Y1FMMnvj
	e0kiobfyPdEGREMjkT73J7eMpRJTqJccPtCAN1YZygt1ROzpXc00z+n6T1LWJLGZ4J1NG8rb5HE
	TiQJPDnAQ+kyN5ubuXHYKxriSV/zXkFjae7FeSn1GH3/AoI6teLwuOwPwus4bnzwnzR59qr22NH
	ioWxUr+fOnRTNXOHYuf2YdkrmLb/IHub850kDOfjMIrA0g9XjWN09cno/JiiCyId83E1XKdFg6T
	Q3sn52i1VbX/8Qhe0lRXq9pBndcWFJr5E+
X-Received: by 2002:a5d:5d82:0:b0:436:da9:4371 with SMTP id ffacd0b85a97d-43958df1144mr9512620f8f.5.1771496860699;
        Thu, 19 Feb 2026 02:27:40 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc8b1sm50341008f8f.23.2026.02.19.02.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 02:27:40 -0800 (PST)
Message-ID: <c9d056fb-b2ae-4631-a2b5-f55f214adecb@linaro.org>
Date: Thu, 19 Feb 2026 12:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 2/3] firmware: exynos-acpm: Count number of commands
 in acpm_xfer
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260214-firmare-acpm-counted-v1-0-32af5735470e@oss.qualcomm.com>
 <20260214-firmare-acpm-counted-v1-2-32af5735470e@oss.qualcomm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260214-firmare-acpm-counted-v1-2-32af5735470e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/26 2:39 PM, Krzysztof Kozlowski wrote:
> Struct acpm_xfer holds two buffers with u32 commands - rxd and txd - and
> counts their size by rxlen and txlen.  "len" suffix is here ambiguous,
> so could mean length of the buffer or length of commands, and these are
> not the same since each command is u32.  Rename these to rxcnt and
> txcnt, and change their usage to count the number of commands in each
> buffer.
> 
> This will have a benafit of allowing to use __counted_by_ptr later.

                    ^typo, benefit.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/firmware/samsung/exynos-acpm-dvfs.c |  8 ++++----
>  drivers/firmware/samsung/exynos-acpm-pmic.c | 14 +++++++-------
>  drivers/firmware/samsung/exynos-acpm.c      | 12 +++++++-----
>  drivers/firmware/samsung/exynos-acpm.h      |  4 ++--
>  4 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
> index 1c5b2b143bcc..55ec6ad9d87e 100644
> --- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
> +++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
> @@ -25,11 +25,11 @@ static void acpm_dvfs_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
>  {
>  	xfer->acpm_chan_id = acpm_chan_id;
>  	xfer->txd = cmd;
> -	xfer->txlen = cmdlen;
> +	xfer->txcnt = cmdlen;
>  
>  	if (response) {
>  		xfer->rxd = cmd;
> -		xfer->rxlen = cmdlen;
> +		xfer->rxcnt = cmdlen;
>  	}
>  }
>  
> @@ -50,7 +50,7 @@ int acpm_dvfs_set_rate(const struct acpm_handle *handle,
>  	u32 cmd[4];
>  
>  	acpm_dvfs_init_set_rate_cmd(cmd, clk_id, rate);
> -	acpm_dvfs_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id, false);
> +	acpm_dvfs_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, false);
>  
>  	return acpm_do_xfer(handle, &xfer);
>  }
> @@ -70,7 +70,7 @@ unsigned long acpm_dvfs_get_rate(const struct acpm_handle *handle,
>  	int ret;
>  
>  	acpm_dvfs_init_get_rate_cmd(cmd, clk_id);
> -	acpm_dvfs_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id, true);
> +	acpm_dvfs_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
>  
>  	ret = acpm_do_xfer(handle, &xfer);
>  	if (ret)
> diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
> index 44265db34ae6..26a9024d8ed8 100644
> --- a/drivers/firmware/samsung/exynos-acpm-pmic.c
> +++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
> @@ -63,8 +63,8 @@ static void acpm_pmic_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
>  {
>  	xfer->txd = cmd;
>  	xfer->rxd = cmd;
> -	xfer->txlen = cmdlen;
> -	xfer->rxlen = cmdlen;
> +	xfer->txcnt = cmdlen;
> +	xfer->rxcnt = cmdlen;
>  	xfer->acpm_chan_id = acpm_chan_id;
>  }
>  
> @@ -86,7 +86,7 @@ int acpm_pmic_read_reg(const struct acpm_handle *handle,
>  	int ret;
>  
>  	acpm_pmic_init_read_cmd(cmd, type, reg, chan);
> -	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
> +	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
>  
>  	ret = acpm_do_xfer(handle, &xfer);
>  	if (ret)
> @@ -119,7 +119,7 @@ int acpm_pmic_bulk_read(const struct acpm_handle *handle,
>  		return -EINVAL;
>  
>  	acpm_pmic_init_bulk_read_cmd(cmd, type, reg, chan, count);
> -	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
> +	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
>  
>  	ret = acpm_do_xfer(handle, &xfer);
>  	if (ret)
> @@ -159,7 +159,7 @@ int acpm_pmic_write_reg(const struct acpm_handle *handle,
>  	int ret;
>  
>  	acpm_pmic_init_write_cmd(cmd, type, reg, chan, value);
> -	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
> +	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
>  
>  	ret = acpm_do_xfer(handle, &xfer);
>  	if (ret)
> @@ -199,7 +199,7 @@ int acpm_pmic_bulk_write(const struct acpm_handle *handle,
>  		return -EINVAL;
>  
>  	acpm_pmic_init_bulk_write_cmd(cmd, type, reg, chan, count, buf);
> -	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
> +	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
>  
>  	ret = acpm_do_xfer(handle, &xfer);
>  	if (ret)
> @@ -229,7 +229,7 @@ int acpm_pmic_update_reg(const struct acpm_handle *handle,
>  	int ret;
>  
>  	acpm_pmic_init_update_cmd(cmd, type, reg, chan, value, mask);
> -	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
> +	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
>  
>  	ret = acpm_do_xfer(handle, &xfer);
>  	if (ret)
> diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
> index 0cb269c70460..242745e8394c 100644
> --- a/drivers/firmware/samsung/exynos-acpm.c
> +++ b/drivers/firmware/samsung/exynos-acpm.c
> @@ -205,7 +205,7 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
>  	rx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, rx_data->cmd[0]);
>  
>  	if (rx_seqnum == tx_seqnum) {
> -		memcpy(xfer->rxd, rx_data->cmd, xfer->rxlen);
> +		memcpy(xfer->rxd, rx_data->cmd, xfer->rxcnt * sizeof(*xfer->rxd));
>  		clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
>  	}
>  }
> @@ -259,7 +259,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
>  		if (rx_data->response) {
>  			if (rx_seqnum == tx_seqnum) {
>  				__ioread32_copy(xfer->rxd, addr,
> -						xfer->rxlen / 4);
> +						xfer->rxcnt);

now __ioread32_copy fits on a single line, without bypassing 80 chars

>  				rx_set = true;
>  				clear_bit(seqnum, achan->bitmap_seqnum);
>  			} else {
> @@ -270,7 +270,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
>  				 * after the response is copied to the request.
>  				 */
>  				__ioread32_copy(rx_data->cmd, addr,
> -						xfer->rxlen / 4);
> +						xfer->rxcnt);
>  			}
>  		} else {
>  			clear_bit(seqnum, achan->bitmap_seqnum);
> @@ -425,7 +425,9 @@ int acpm_do_xfer(const struct acpm_handle *handle, const struct acpm_xfer *xfer)
>  
>  	achan = &acpm->chans[xfer->acpm_chan_id];
>  
> -	if (!xfer->txd || xfer->txlen > achan->mlen || xfer->rxlen > achan->mlen)
> +	if (!xfer->txd || (xfer->txcnt * sizeof(*xfer->txd) > achan->mlen))
> +		return -EINVAL;
> +	if (xfer->rxcnt * sizeof(*xfer->rxd) > achan->mlen)
>  		return -EINVAL;

how about:
        if (!xfer->txd ||
            (xfer->txcnt * sizeof(*xfer->txd) > achan->mlen) ||
            (xfer->rxcnt * sizeof(*xfer->rxd) > achan->mlen))
                return -EINVAL;

>  
>  	if (!achan->poll_completion) {
> @@ -448,7 +450,7 @@ int acpm_do_xfer(const struct acpm_handle *handle, const struct acpm_xfer *xfer)
>  
>  		/* Write TX command. */
>  		__iowrite32_copy(achan->tx.base + achan->mlen * tx_front,
> -				 xfer->txd, xfer->txlen / 4);
> +				 xfer->txd, xfer->txcnt);
>  
>  		/* Advance TX front. */
>  		writel(idx, achan->tx.front);
> diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
> index 2d14cb58f98c..422fbcac7284 100644
> --- a/drivers/firmware/samsung/exynos-acpm.h
> +++ b/drivers/firmware/samsung/exynos-acpm.h
> @@ -10,8 +10,8 @@
>  struct acpm_xfer {
>  	const u32 *txd;
>  	u32 *rxd;
> -	size_t txlen;
> -	size_t rxlen;
> +	size_t txcnt;
> +	size_t rxcnt;
>  	unsigned int acpm_chan_id;
>  };
>  
> 

