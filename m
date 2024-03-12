Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4B79DA1
	for <linux-hardening@vger.kernel.org>; Tue, 12 Mar 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239752; cv=none; b=GI2uDMEUfuG5hjMoeEykzmhmcy10L9YrkR4a9OqDPs8qd1qAg/uf8ImOCKd8Ze4W8E2PSwNo1eEfSkSSxaxFpGhLOKX+77aiWwa02cSadHHP+kjNRoARXhptVTXzxFQVzVESF3SdbDubuugGnbtlZtaWAbUUtFYtJYjEnWRSlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239752; c=relaxed/simple;
	bh=J87wPB5kfR1Vgy0rpL+lAvnIl/mRMrKHOZE0us+WmkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7q/EO2qTZ+8alls7Q6xp62dqSpRqrXd19CU7ofOn3kYoQK+Gg3PUxoQXmyZqbbwPglEwluo7n86Ot/n6g4Eq1ulJ8OPw32OvcTRABkENi6XoxOLiVbQ7xKmm1RPID9iCa1mORukwRvc6sZM/dVe0ITWE2A4oq0NAnDiR2Ex40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gT4LbfdA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gT4LbfdA"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5133bd7eb47so6363114e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Mar 2024 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710239749; x=1710844549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gT8NsrDdn/4eUzU6LsHlS9sX2d6WD+4RS5GzUvLPnDg=;
        b=gT4LbfdAjLd/ZG/7+LZq/Xyzvjpq0mgMoDSesLF1yJe6Bm0Ya0eA6MFpFpANGSWJmz
         npncWr9EDexb35HohsGrxUnt6ywBNlYQy28LjC1qiB5+C6AhbD6MR11HOdO8aV0R+BoN
         8b0hD2RcZTUDO0ezZJI5mMnv6wZOU62+7GOK1C7m8UoG8UaYXgTSrbF9VnO0e98PZ3Cr
         J/gmhHIJdEcUW5+nGyzTSm59iWq7mA+3ipUD5QYGHTy+34OQMB5Ias/dq3hUCLjD9eGx
         0qi/BgPG1UodV6amoA1+hc21UpAppHd77qxAleaOyeo9LjPECz+cdIuI/OWBbvm3QpNQ
         0GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710239749; x=1710844549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gT8NsrDdn/4eUzU6LsHlS9sX2d6WD+4RS5GzUvLPnDg=;
        b=gTdIMk629dA0XKneyFw0BW2CYKpo6tyXnNPGwz2iTZc78maL1p4hxZFY061Ws8iCLW
         7gjSqnEe09n6dt1TNaPztkLyfvckujw9NEOuQ+jS0VT9/ed/llrn94TXozYxgFaXuDca
         dFvvU0X2v5BDGbLrpJEOTx3wV1bAWPSq3V3dno5VmRBz2JsWMHLmbufTvzGthEwSHYgR
         QgdcTqUaIkBhXUnInvZaGbhTuVar8I+XHJHqEUK4EDZwFkk1nZkaDvuvQqblP/fyNaug
         43FrA8XEebt7nxrTRWnqQEsqC+MLcVmjFuubDkYlaBJ40xuSfuJIWu5zndu4QZC2J1dR
         sZuw==
X-Forwarded-Encrypted: i=1; AJvYcCWrsHHoG2qpYKqNOosH+E2Xp6gApfxn9EwLtyvrXiLSs83d7wKyTyMVqqUkSpq6GRjtSlbfuz/vGIJK+Zs74KP/AbIgn1Yhgncgmo58ZmKD
X-Gm-Message-State: AOJu0YyTaF4HKFfXzBf4Gtps2XTikd3oxS0AHszwPi5VgS8ss4j98T/2
	dsKhmQNIZQ4DhfORpZtQzIKuJ9GJrwUNNTe2ipKu3dvEq37HGaV9VNxYE8ekdbM=
X-Google-Smtp-Source: AGHT+IETlifHZT+hAAKWHTZL07PZLEEtbBwZ4zEw20Dkdb3oSqUSUH1qMOIS6ZeDJ1M80KTwsIsTiw==
X-Received: by 2002:a05:6512:ea2:b0:513:b0d4:da40 with SMTP id bi34-20020a0565120ea200b00513b0d4da40mr3272425lfb.20.1710239749100;
        Tue, 12 Mar 2024 03:35:49 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m24-20020a056512359800b00513c104ace9sm167986lfr.198.2024.03.12.03.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 03:35:48 -0700 (PDT)
Message-ID: <feb1be8f-ed13-4925-b284-27303651e933@linaro.org>
Date: Tue, 12 Mar 2024 11:35:45 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sc7280: Add clocks for QOS
 configuration
Content-Language: en-US
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240306073016.2163-1-quic_okukatla@quicinc.com>
 <20240306073016.2163-5-quic_okukatla@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240306073016.2163-5-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/24 08:30, Odelu Kukatla wrote:
> Add handles for required clocks to be enabled for configuring
> QoS on sc7280.
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 7e7f0f0fb41b..e1d8fb6afae8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2129,6 +2129,8 @@
>   			reg = <0 0x016e0000 0 0x1c080>;
>   			#interconnect-cells = <2>;
>   			qcom,bcm-voters = <&apps_bcm_voter>;
> +			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				<&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;

Please align this with the previous <

Konrad
