Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0C14F9DA
	for <linux-hardening@vger.kernel.org>; Wed, 27 Mar 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541674; cv=none; b=RcqNN/VEdw5XzoPbt0aOAK2z23W+5+DMRMF0bWyWGP/ep7rdvG4BI3qOlTuxL6Hsj7fXPgM90GrkY6280hOojV3ZyVcA/H+9Sueos3T0YdkQaqN7BEygYy0ejAhkTlUYxqUXz2sS7JGtXUKA7P87sDVYQpCIeHT6AuLFl+CFRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541674; c=relaxed/simple;
	bh=DfLAtBXOml0ZHv/vuCzIRqfVCDS0wiJ6vIpBTdA5umw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWdQTEcuydtP7c+E9u0/dT3gQwuLX330I7xoyj3wsSLGs+6FUyoyx+hUSyPwbQ1TskbO0rSlI3L2/u+fzkIPXtLgX3ooycR7vZn1NBSIEUMeU+cLL1RFSMorQDdV6MNQBv3jIICaH/0c78xY/itRrJT21GRT4WDgbVf01vWyMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KYo824Qv; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYo824Qv"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d28051376eso119596311fa.0
        for <linux-hardening@vger.kernel.org>; Wed, 27 Mar 2024 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711541671; x=1712146471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3xdn0bmxbdPnG8CL0tnafiMnTKvgL7tugfezcKdSCuE=;
        b=KYo824Qv2bU+Dcrdm467FYCaHRWx7EuZvb0UlQ7ybl6cjTPmfW2ZQFyuLcZXWybC24
         XP4vZmLnXBPJwDEGJ4xqy1ikFyQ9R+PHud3936wgl4ymLeYBYq8aV0pzjT8kGCTb81Hb
         oEnvBF1lVnnKTvuntPJ2sBZIvyueAyVfFZvUYtRblf1YQNkuY6BRQefQ+UqtqIy3jp59
         lp7nF8ti+ttQRLR5a/hZ2DFglpjNt6YzUE1YkJgkJCvuIaMIKCNounDLapb72ckUJ0ly
         3j7k1ZfcB8V19Ki+ZqSCsa/qzlsFJmx3ySuR6sY/Lz24ajVfDuN9QrcXXL+C9QE8/4YE
         gdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711541671; x=1712146471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xdn0bmxbdPnG8CL0tnafiMnTKvgL7tugfezcKdSCuE=;
        b=vSdHHs1UEaFNAFgK7a3sgI19ahHajlRzXcCZbVlEeJQ+3oODWrZ4iUUE1UInDglrwJ
         qTdnGH7U7gNXfwRkUScEOQ8p9c3RMtlGdpOdD62yOrRMpD5ppeWfHA5YQeQn/gTIMQzg
         H/sddyfp1+jhV2G4LjKXNw0JsjFJarLQPdXha/PrR5TckOoboOcIDsjQcj+O4C84cOHP
         lE4oHH25jxkoSA4Sj6v/wPet5nEvUjZtSHBnJZQP3mRYI8UVk5nDgtxzAGc1sZPXalIi
         Dhk8DjmcPHweuBAbYKxZJWqEfqivfVkGKt1rBB2WEsUXy2kK9sk/C9NOFzq/rmdoYTnt
         3iyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWojWECChlSD/BCZOA9XMtfKPwyJdalCX1X131BTC3duoY+TTFOTqDASdPbyOZxSBL6tBL3ZGx2ceKNnmb/21o0iTutU1yeXZfvF87WYFF4
X-Gm-Message-State: AOJu0YyzeWtlz5z44vMw8lGZUjYOpbG1UMw/bRFUsMI/YqtY6LuBJoj6
	/EFa9GIhBMgbxM6p/H2hYu3iI2C4Je26ilsBvQMPIc9wxol6ubirZE+XlqXd5VI=
X-Google-Smtp-Source: AGHT+IH6PW7Cf/IUNcgwpZRH8VU4Lva56wRfvxGk4R/jmhmjR3kxNnIPEynu0RD1bg8l1Do5zA2vRg==
X-Received: by 2002:a2e:a0c2:0:b0:2d3:8c1f:c0ff with SMTP id f2-20020a2ea0c2000000b002d38c1fc0ffmr2004067ljm.16.1711541669917;
        Wed, 27 Mar 2024 05:14:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id jy12-20020a170907762c00b00a46ab3adea5sm5370213ejc.113.2024.03.27.05.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 05:14:29 -0700 (PDT)
Message-ID: <99bda06f-8e2f-4f51-88f2-d99187e29b92@linaro.org>
Date: Wed, 27 Mar 2024 13:14:27 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] dt-bindings: interconnect: add clock property to
 enable QOS on SC7280
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-4-quic_okukatla@quicinc.com>
 <a259fa95-bfc3-4959-a159-8683df473e66@linaro.org>
 <e95634ba-b186-4fee-b93b-1ac4662fd2c4@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e95634ba-b186-4fee-b93b-1ac4662fd2c4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 12:35, Odelu Kukatla wrote:
>>>      maxItems: 1
>>>  
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 2
>>
>> Why is this flexible? Nothing in commit msg explains that. I gave the
>> same talk twice, gave there examples, yet it is not enough...
>>
> 
> Clocks property is optional, and can be either 1 or 2 or none.
> I think "minItems: 1" should be removed. If no clock property is mentioned in node that means no clock is required to be enabled for QoS configuration.
> 
> I will add back specific number of clocks based on interconnect compatible similar to what i did in v3.

Just be sure you read the example I gave you.



Best regards,
Krzysztof

