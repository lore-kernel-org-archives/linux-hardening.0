Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38413A899
	for <linux-hardening@vger.kernel.org>; Tue, 18 Jun 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722072; cv=none; b=p6Q+8eC5+8gursZEiOpbfMbpeC395L99FDiuqPUnUKjiuP4lhfgdeBAn6mj6/ePoHAA4paY3g4pRWFpx0jM4FEYYkfMKdh+3DT+wQQ5gupjl389qo7a05dsy2JC0M8TlDjXj4Zgv0eOP4DBpL/1JFGveZmvWkbqoukMguWfogD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722072; c=relaxed/simple;
	bh=IZZnds0VRHrm2Ii8hE6YeOS6qZ0PTeuu48RLJyyIyXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7e+28LCVM+B3g3hq8ajGifwJaBdFtNbJv/9xRlQiYTzkypWKqB8hlc0VPDiQcDrEoY9VI6OrXtiMjS8Y4bt/EpvumhArmCah1N2OHIBA/RtJG5DyDR6TBUypuMH1IWx07OYCzxZeXozB+SYc06ycVl6UtL3P+C6BpmQEM1SewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BnRwdUwZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnRwdUwZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso44896695e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jun 2024 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718722067; x=1719326867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJ3dYX4GpJ/TRHjWJ/CxptBXzc0wGdknCikvdomgmWg=;
        b=BnRwdUwZXP15wxEg20PWKAHy7YAHMEC79MGx1WtVO+EaUbqNxDsSISxVmj3b+tuY9t
         Zgx2suuLRXNgi6tGDp6yohZYXYET2of0ZI8qS+rBoCBm92DtNIG0mO7nMQv9SR196lrK
         2oiGVVDMdXvYZ/uFZzRAwcf50xSYZxW0db2qoDcDeJDti46NlaW+4CnNG6zzUKhfIB/A
         2lzlNrq18ztrQwzFtdYQhwL/QCqYY01IPCbkkDev8gmaX5RMWzq3uQ47/A/AyMt86xMe
         82ibvnyD3pYEMaDzXXssJ8rFDVftyUTp/g+9RrhG9nX8cnatIGAPnACUGalaCrd7HJ2f
         cquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718722067; x=1719326867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ3dYX4GpJ/TRHjWJ/CxptBXzc0wGdknCikvdomgmWg=;
        b=TOuWfO9E6M9D2Ob84iHuuGBT5+acJJC11cQdp1xwJYHyUmVD8dUGsMfItu14JL4hpy
         STBFQ5Irol9iYsdhTS8DxFtfrR8rd2iKXCee66xfsojRrKwl7opY2evLSsilXTVTCz9R
         iOhsEE/wOqkOQPxHWcwx8BuemPe8b9UT7p/j7I5/QNOgvUS8DwasvZf9bwruPer/HaDs
         RanZZ9k8NYNhdEmomJxTloAvOYdo8H/A8EubkUJblkT45bVKv1Pr5aLY/jYOmW/LtZqB
         pRmIRBw5MmX922pleMCZqN9v0gbWksyy7BX0kQ7vTn4aOXD3bxY9EZHYrHpZl5xpH8et
         exCA==
X-Forwarded-Encrypted: i=1; AJvYcCWljnb2XjGXQbEj/4KKz1g/2UqDvCVywQNxFFGV+p4DePW886qyuJwciuMXAIy7WpHQxuhyrLO7yb/6FwKCrPu8rvC2ov57uWNiSN4S6ZU5
X-Gm-Message-State: AOJu0YwgterbwkIb4edIklf9yCecI7+lnC8kJmIqC8c8kIYKQT9/m36R
	Xtl1If5qT/YwIan1ernSkicETFLJvssguf4LgRzNLMWbNhcyH6rs4BpznlzNeGg=
X-Google-Smtp-Source: AGHT+IH7I/dhyj73BogJTxO5E8ag28pj1oQQCYT3fMmsc47p/80bkTRhwGBL+ram+v9dMFIqbI5/7g==
X-Received: by 2002:a05:600c:1d8e:b0:422:5443:96aa with SMTP id 5b1f17b1804b1-42304827573mr106149055e9.15.1718722067337;
        Tue, 18 Jun 2024 07:47:47 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de63asm229867065e9.30.2024.06.18.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:47:47 -0700 (PDT)
Message-ID: <36687425-0be6-4616-a3b0-9870bb187e34@linaro.org>
Date: Tue, 18 Jun 2024 16:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
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
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
 <20240607173927.26321-2-quic_okukatla@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240607173927.26321-2-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/24 19:39, Odelu Kukatla wrote:
> Add QoS support for QNOC device for configuring priority,
> priority forward disable and urgency forwarding. QoS is required
> to prioritize the traffic originating from different interconnect
> masters at NoC (Network On Chip).
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
