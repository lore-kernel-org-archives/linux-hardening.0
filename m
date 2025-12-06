Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBC2DA77E
	for <linux-hardening@vger.kernel.org>; Sat,  6 Dec 2025 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765058026; cv=none; b=CBkS/zACEC4CvGlzJdFyqSn1JYEBeVbIdW6QjVuHNd4nzgcmZkfvgv0jgp/BIhXXhBZPN3ESmYJMYXmP1pHvUfQulSuCMurliq0qOea69iXnOf6lhXztvnFMTtFsqzmrS9gCSHCQGvw97LGToveXmdBuLkFl33bWgEjXvzzOKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765058026; c=relaxed/simple;
	bh=43TX5frqeFMefjQIw3xSaro6MZidnaNM32Znkp2b9JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdcOfvXvSONKEZC10W/ZuuTsOLfRma+7NKJ5j9b2Fmq99o6PaGbDjEQ1YAU3kzc6vjgN4hNnHrtEBUCCov5SPp355ChVbxHzxC+jowBb+InPnjLDJop3bI/rdqV9irLNNF1ofomQpggWXFfTOvfL3iOzs5Gi34q7+dL9j+y/5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKfllvQ6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKfllvQ6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so41991305e9.2
        for <linux-hardening@vger.kernel.org>; Sat, 06 Dec 2025 13:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765058023; x=1765662823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlSc46iEGMKsSwCu/roR86i2e0LFt7xxWxcFqpVt+ug=;
        b=dKfllvQ6rOsLe51Hfikl9pIM1Q+bSFybpOGnLLagzzPx53FHNboQgbOxW9KMnHb2a3
         lnbD2riOnlpritWbi5JfuRBYzG3AEUm1Pu2ce6EEw8fb5dlioeIzryOuo4HYg88SrZ6O
         umrzPfewH8aIpD7zZtsSqahwxfjbmY5825VwfP+UejxrI7Pgh6xtYfEORLhnjJ9iV2Vl
         24g4mK5QFoJK4cK8j0xCS9mRnKSsYCf/UEawBWcyzdyHxflYMJg2fIGQjZJZWUWd/dqr
         f/PqNfOAIYQqVyGVyOWxTyVHadDVY77KOs8V8969POhZ67rMQl5CrQ4XHjT0VDSqyeEf
         BGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765058023; x=1765662823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlSc46iEGMKsSwCu/roR86i2e0LFt7xxWxcFqpVt+ug=;
        b=FOFAVBnbuBVVRv7mXwb+7tmPO9BbCyXTH+8is9LTNeADw/PeYg5JlHK77ljHQWJ/0f
         1zZthOcgRA7oFEGAbntD5LiWQ0rb0zO4oWeCdGyco+PkecsY+h00ohN6xPi0mCaT+z9c
         DgBqp2Eb8hjJsg78F3WI1HIEEm2dtDi9VFNGUuGtOKn/feFXi8kvN7t/aPFnuGLlzuis
         lblsjwpSi/sVua2PRB8AathxwsqUdFTml862vFucnKwH3QpKU0SILgIf3w6S/ttOYPuG
         WlqlKr7sSWwTGAwqIaumNBS+Ps5S2ZQxBZYwHNWDVW06ZbIFpXD1ZlSanj/VwYC1LxB0
         6pGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg9wVVSz3zIaG0r5lG0wK17/CeP2eSaC1L6tgmAmoS84swiiAa8kYs8gDs4kil+2pjBpJf4jbpC2bR4berzJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXPBQjrZld6xjRAvcTRspFyOTrxEuVSgYQk0o5D15r+zNYdGuY
	cuCAivfY0oWgp4sQa1MIY9GXZWi5APQXZJoiaATYRMJ1VWVzpQJFQz/0
X-Gm-Gg: ASbGnctMYIui8AyQGN27ixVqE6oL8t8xXNOh1nrRLKVNglUmbebvv6yha+3PdoGC4uD
	OXv8uc7+0LvrGnjnDsTbXw1HgLOVUTieURurnfZ7NCBjt2onN04FysoqehimgzDeiLGT3Z+Ag/v
	qNbuecn/8hmNBf7HHq3SLLOLI33uL2p90h7JXlwKf8KRt8XtMHn3+wujo7h2YrHxUbfufJBXJOa
	huiVQaLbptzEXygIDr1kDBial3xWJtf1PDe0fraqkhm4v1gqMzByVyFDhYHkZgthAxDR5j/QUo3
	IUYfgVqdZCe7flM2TeOT7xQe2SOtEZgxlS5AWXE4j4RjJc0z82D43b2Sjj44w81jVG2BwwdK2cB
	0+I6vY1xphBhcPDgWbxx5pwTI6BYDdUzskaKybW5eDjjjHVc5F3b4eaQSBl5N6iC5J5afCDEk0E
	GxD2AgsxAPN42RxhMGbJiI
X-Google-Smtp-Source: AGHT+IHbCGiQk3fsXEj22BoPr+p1X+aNsAMv3ycLRRhbH+uIBzuybMZ3eZdnq4HZjmb9nLBzlNXi4g==
X-Received: by 2002:a5d:64e3:0:b0:42b:39ee:286f with SMTP id ffacd0b85a97d-42f89f53e46mr3097057f8f.48.1765058022382;
        Sat, 06 Dec 2025 13:53:42 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff352sm16634775f8f.17.2025.12.06.13.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 13:53:42 -0800 (PST)
Message-ID: <44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
Date: Sat, 6 Dec 2025 23:53:38 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
To: Ping-Ke Shih <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>
Cc: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-usb@vger.kernel.org
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
 <20251121111132.4435-1-zenmchen@gmail.com>
 <475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
 <c0d187d6fead4e5387db2a14129be96c@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c0d187d6fead4e5387db2a14129be96c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/11/2025 05:26, Ping-Ke Shih wrote:
> Hi Bitterblue,
> 
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 21/11/2025 13:11, Zenm Chen wrote:
>>> Gustavo A. R. Silva <gustavo@embeddedor.com> 於 2025年11月21日 週五 下午6:20寫道：
>>>>
>>>> Hi,
>>>>
>>>> On 11/21/25 19:06, Zenm Chen wrote:
>>>>> Dear maintainers,
>>>>>
>>>>> With this patch applied, my system always freezes right after the rtl8xxxu
>>>>> driver is loaded. is it normal?
>>>>
>>>> I don't think so... It probably means that struct urb urb; cannot really be
>>>> moved to the end of struct rtl8xxxu_rx_urb or struct rtl8xxxu_tx_urb?
>>>>
>>>> It'd be great if you could share a log.
>>>>
>>>
>>> Hi,
>>>
>>> Nothing helpful found from the kernel log. Maybe Realtek drivers maintainer
>>> Ping-Ke could take a look what is wrong next Monday.
>>>
>> [...]
>>
>> I got something. In my case everything seemed fine until I unplugged the
>> wifi adapter. And then the system still worked for a few minutes before
>> it froze.
>>
> 
> Zenm and I tested below changes which can also reproduce the symptom, so
> I wonder driver might assume urb is the first member of struct, but 
> unfortunately I can't find that. Could you also help to review if something
> I missed? Thanks.
> 

Sorry, I didn't find anything either. Maybe someone from linux-usb
has an idea? The errors I got are here:

https://lore.kernel.org/linux-wireless/475b4336-eed0-4fae-848f-aae26f109606@gmail.com/

> 
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1942,15 +1942,19 @@ struct rtl8xxxu_vif {
>  };
> 
>  struct rtl8xxxu_rx_urb {
> +       u8 pad[128];
>         struct urb urb;
>         struct ieee80211_hw *hw;
>         struct list_head list;
> };
> 
>  struct rtl8xxxu_tx_urb {
> +       u8 pad[128];
>         struct urb urb;
>         struct ieee80211_hw *hw;
>         struct list_head list;
> };
> 
>  struct rtl8xxxu_fileops {
> 
> 

