Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3EB262D16
	for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714572; cv=none; b=HeGCF5YalrDIcIFjZM5uAhsVzEP8NILOmSdQQYOA563J7ua5oLe+rhmqlN5yesuw4SshbROmbbPQDw11Ab9YgoSuVTzxg/mYsnwFgptyeVGQnhgGuA1SeqojpY7zvAJic47QnCsDRciZtvfJUZbNrIBrHy3ab8jF0bKD648snkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714572; c=relaxed/simple;
	bh=5aUsqOrI16iMveQNEajx0BokuB8rnFuNsAld9sPRVSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+pLQYttPTSA1WSgk0GgD6XoB0Z2oR2JG/HsfNvC2VQgC6sBI1BhB1g3HLivlXaANeXHVxY5PD3FkRmL/n1jvLNOElktBNiaKELgFYkmPZw+ku+g0EXJJds2riAmsv1V/fV95opcjPRTEzAyA0K6GrC/SZilPTcTUeNdLRPYiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YJlDg6+G; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YJlDg6+G"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c2c754af3cso1257968fac.3
        for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741714568; x=1742319368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/AZGEVmfxF0jKoqVNVNRMBGz9sxfr8KBwzFyulmeIs=;
        b=YJlDg6+GFLBTrY5+hbodE6loh2u46+g1BNHmXUiata7GIe7AyA7U97p/a4f+9QdmGG
         MIxBquwZV7z4DtCoOXGES3AZteZc+Ei8I7q522qbgL6oHGZ9Ws8qNIYWxQOuWqD7m18U
         3YI3M31CEnkJ999vm+dQ0Luq3gaY7FwlAiA4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714568; x=1742319368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/AZGEVmfxF0jKoqVNVNRMBGz9sxfr8KBwzFyulmeIs=;
        b=ZVRMl6ZMQ5IB3/+WDHh7TGqEIdViRtPagptZHQg1XyRAUqTdnyCU5t1Mjv+iykb6i6
         o6kBZngrIHZZP8xwGVOJ9jYqzXcREfphZdBQTv2z0LxzV0Zv8WjEwCsebXs84a744sQC
         WNo3zMA81UsTjdG7ECylOIconxGkt5tgMpDS84kLqAsbbVW5MDJP8cVA4pBt7Ud8NxEK
         sVrejd208q0rbwpneeXu54jUSUNR1jlQriOrLrTrWO7AX+Q7ldhGcMP+Q0zmn8krPJ1J
         L/kHPq0UBxxz3Qd9JaQTqk/d1myyW/hUEfmvMxPjHqHL/89i9fmtaQXn6LiZ9o8vPlsg
         nMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsPf2nas4wFJH9m8MMHkA6HBR24GE5hoJHKzl7Swh1tmd1wPlyhN3ytOe6Jgktbpg1/o6U0JlmR6Ni7lsLwaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSce1/2ySdsL+rKBP8XUr3H2V8XjtIp3tgppqdNnTQPHDaSWO
	KK7lD4uKic+IGcU4YzCnDUojW0XF07PtyxoRPxV5vPbW9zWhCXG3ITfpsclaJw==
X-Gm-Gg: ASbGnct8rDH9gVVSKemeZx1DlrYu7H60PerkCIFzIcxXeZcfyCw0HtAb9msbZS7Nl7m
	GGYbxPdBiFo72RNMbGgIGhazZ3E3SrjfdWzaVunI4IpsstqEPx1mnycx5kSChsXZ+fxV27du980
	Y6Jt+Eamwpm3fzLaZRLSctW3VAmrVcSPisz8F0bek//wVoEjhMDoAP72GGDboOmXxW05spEzQKI
	Pm509tLcFdZCLOTpEU30Qq6QDYEuJnSL4JaIE6mSuN1giIt0gRfdEkh6uSIUhAZp44WHJ5WHwih
	nkHYUoVSEe+352hhFOzO8i6qIlgBujipeMFFAxMw7a8+bAdaGlSX14jrbmlBztvZX+9ppVC94OR
	+13BN
X-Google-Smtp-Source: AGHT+IF6stv4KV1HaEag5+77smmBKlZX0b6JVQBTx2uQ9Bg2ZjG5KNAD+BqnyMHU0PQVstMcpo8f2A==
X-Received: by 2002:a05:6871:8416:b0:2c2:c404:465f with SMTP id 586e51a60fabf-2c2c4044b38mr3090975fac.6.1741714568018;
        Tue, 11 Mar 2025 10:36:08 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c2d749e115sm661597fac.13.2025.03.11.10.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:36:06 -0700 (PDT)
Message-ID: <9188b3d1-ee61-c1d1-f06e-854ffd2ccff7@broadcom.com>
Date: Tue, 11 Mar 2025 10:20:05 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] misc: bcm-vk: avoid -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z8_twT77rSIK-S_-@kspp>
Content-Language: en-US
From: Scott Branden <scott.branden@broadcom.com>
In-Reply-To: <Z8_twT77rSIK-S_-@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gustavo,

On 2025-03-11 01:01, Gustavo A. R. Silva wrote:
> Hi all,
> 
> I'm trying to fix the following warning:
> 
> drivers/misc/bcm-vk/bcm_vk.h:415:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> after a quick look, I don't see any code directly using the flexible
> array `data[]`, so this patch should probably suffice:
> 
> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
> index 386884c2a263..9344c2366a4b 100644
> --- a/drivers/misc/bcm-vk/bcm_vk.h
> +++ b/drivers/misc/bcm-vk/bcm_vk.h
> @@ -311,7 +311,6 @@ struct bcm_vk_peer_log {
>          u32 wr_idx;
>          u32 buf_size;
>          u32 mask;
> -       char data[];
>   };
> 
> What do you think?
If it is changed to data[0] does the warning go away?  If not, you could 
remove it or change the code to use it instead of the sizeof used to
calculate peer offset.
> 
> Thanks
> --
> Gustavo
