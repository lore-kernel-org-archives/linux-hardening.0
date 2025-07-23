Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B20285CBF
	for <linux-hardening@vger.kernel.org>; Wed, 23 Jul 2025 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263689; cv=none; b=gdw3iFWhGqddfFAYfebE8y3oMsbabuffUD5A3z1nW47Q00M83y5kC29yPbcBqvqVUrZMF/V26xcMK8pNnezEy5CJE4fkC/CysOL5ThKotAd5HxBDD2kspSBFpHg11d+QjU9NnyBi+xrTJHwf87/45rA3UMsoqlm8AZhKKEm2QtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263689; c=relaxed/simple;
	bh=Fpdmetq8rTUEqq9WkszaFi7bbWvejmQcpH5dX9vmY9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEJKsuRN6GyNfyIDs2nH1KLz0RHetz+gN0/gXV0msyWJOvS19w6NXZkVtOZ8+WmVBKYkNX/BjMePTIywCjc0mtHng/cB30PshX//63GkTBcAUs9XxT53/QiShMAwTul25rPdSfJOrBL7fOWv8vCbK663zxGTattxxQSK4uGEgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OcKagD0T; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OcKagD0T"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab644b8dc1so70058371cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jul 2025 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753263685; x=1753868485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DQm6k6GRfRb1Tj7sFMA4AF0xS4uSgjz3/cpurFAQcNU=;
        b=OcKagD0TiAPBI+edj4xGiwQZ3O0xHrlgwAGt+Ke63PlIQ1e43RjIiqbV2oefX7fUit
         1nyNbbtv2T4j7T17soUbg+tXXaXhsdS6SwAeRJSbZITGL23ThaX247AGdgIIX4A3r2cM
         Ms78ACrbwWQLzIBfRAuUzyuZrhrZhvh+wiYvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753263685; x=1753868485;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQm6k6GRfRb1Tj7sFMA4AF0xS4uSgjz3/cpurFAQcNU=;
        b=BFfiwG9teOeZyng3UBuSidBsDBgrHgIxgrNs0+zNf//X3PaW3tHViaVLxmBPywSR+z
         5JHcReokhU8pPrvWEYz1KzJcZ8BTJZGz3w0LlGfRO4N2WqidK+WG12e2cpQ6P/eKUYNe
         9cS5w+SSOl+EI02VucyNA8hvjTbwbttRm7kBVX0+UHfkVhPcGUC0juaud0UXCo7AMF8b
         UCkrtUPglhWt9WWljRnnlnFdrRjefFuGnT2W2IK606SianKQ4BdWl4nZSlEYxPwSsaDz
         mhoxq6ROX/bAOkaNFxKptZEienEDF1/DkI1NDQECsSn3su2seXERCI0iNr8IvadPy620
         mCvg==
X-Forwarded-Encrypted: i=1; AJvYcCXz8KSEwYWAS+knHB+UzqZxft07f1V8Hp63KrpcudVNLCEL8mNFXYrbz5hSBGCb3U6RIvLuYZWUjfE8V/qgSLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+6qd+Pxucn4/iDDOrMzg7+FJ7QFXfhsA+ASB1ITXgDhyt5Tu
	UiMMV1sL8ZZKzsju+AClvnC1eVI8fsiXdCtOaEHqZhq1ZyPGMEZvljW7dq1/kO+QpQ==
X-Gm-Gg: ASbGncuc3t2K+w4XN5N/L07zlRTysCd4CFQQ7A/o39C90eOz6tZQjxNq0kWctvjhkM0
	tcS0KNfwmB5aiJCM8lNuQIgvVBbmnNeHrMvWfnhaEmdEo+5zRzKctZrirJG3BnadPBdW0n9rPOJ
	qcYNubVHqV1KQegDYxCvppqjWwK7k5iRs/ko9bcITxTqbBccqmA+xEWVk2JaONQiupWRnqnONqP
	bwxCZi21sUE20Tv/7QD+ijrUfaZgXD+Brkblz9QALoFCMTNytiK+6cUpuCkr+Wgk+msV2000wVX
	GXGBZdE9Xh6Ef413zWwrjIfV3gnWHMQFnzzORrRgFeiY+6HtJhx8GKp5EOIjS8uxo1+Lc0/Qf0a
	jstCqRMtCHZ6VwABrlVJB39faguF5UniNOJZqNwQouWKlN7zgC8R6
X-Google-Smtp-Source: AGHT+IEHPgcqDK0ElwBxJD+Ct77IecKVvreRBKmNCknReGOOR5dFBvm5oE5wCWsiVBuPzM1GPGxc2A==
X-Received: by 2002:a05:622a:164a:b0:4a9:85ee:5ace with SMTP id d75a77b69052e-4ae6df3f69fmr29212481cf.31.1753263685416;
        Wed, 23 Jul 2025 02:41:25 -0700 (PDT)
Received: from [10.176.2.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb499fcd2sm65370471cf.17.2025.07.23.02.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:41:24 -0700 (PDT)
Message-ID: <96fa566d-120d-4501-8926-df3a76854116@broadcom.com>
Date: Wed, 23 Jul 2025 11:41:21 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cyw: Fix __counted_by to be LE variant
To: Kees Cook <kees@kernel.org>, Johannes Berg <johannes.berg@intel.com>
Cc: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 Chi-hsien Lin <chi-hsien.lin@infineon.com>,
 James Prestwood <prestwoj@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ting-Ying Li <tingying.li@cypress.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721181810.work.575-kees@kernel.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250721181810.work.575-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/2025 8:18 PM, Kees Cook wrote:
> In brcmf_cyw_mgmt_tx() the "len" counter of the struct
> brcmf_mf_params_le::data flexible array is stored as little-endian via
> cpu_to_le16() so the __counted_by_le() variant must be used:
> 
> 	struct brcmf_mf_params_le *mf_params;
> 	...
> 	mf_params_len = offsetof(struct brcmf_mf_params_le, data) +
> 			(len - DOT11_MGMT_HDR_LEN);
> 	mf_params = kzalloc(mf_params_len, GFP_KERNEL);
> 	...
>          mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
> 
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")

Thanks for fixing this.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Cc: James Prestwood <prestwoj@gmail.com>
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Ting-Ying Li <tingying.li@cypress.com>
> Cc: <linux-wireless@vger.kernel.org>
> Cc: <brcm80211@lists.linux.dev>
> Cc: <brcm80211-dev-list.pdl@broadcom.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h   | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
