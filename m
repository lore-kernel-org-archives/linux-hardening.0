Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369031F191E
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jan 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465166; cv=none; b=A9o5LYMrM9GGmmt7A1j+QX+8GST+BGoONxUkDNVL6BZzf07LALM/b3mg2UZ2JOIBafcK+Gtvkyv30kL/zkF+jtzXg94FPpNdcv8COw1efKwhu4ntVt0YOGkC2DrDFtugMMuF/KjefJavMJyaTnrBIVCGYBshhZzKWK8JCL7ErhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465166; c=relaxed/simple;
	bh=NAIeDNWBPAUV4s2hD2YhjTqYmw23E7vHz0ySOuJHVI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhukWgUsmufw/VkaiU8nN5xltArejuBxN28/8t9LKxK+gZVWbg6bHKZGstd+kJZUW4ft8+ppKvt4duQAr8LwQ0yBj5mHq/zwdt+vZf555CPaB0+kwnKFqmBj6bIrLCxWwDjYJq4xzWjR+iAJ9tAMfQaAEY47w3z6kl7pcvrRWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JKVNoAAG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKVNoAAG"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3863494591bso3050097f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jan 2025 05:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737465161; x=1738069961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2x1boRC7Td3/KtEDErRciKOCKj4bZ9FvBbMmDACL5I=;
        b=JKVNoAAGzkg4HxjC86jel9/jqpGvJGta9XPkA+Yb6fKA2gE0aXgxIYhrt2aB1rsMik
         GMKMUXVfigcVr60xNtmYSPE5WGLBtRkY6035TKJoe1Y2psqBAvPhFbqYEfqU7SpqR54D
         mZdvezQoHYpoRd/9/DJCD7FGfObyGr90lM/qJ3/76VZinttNVLg/XMlcLIO8F6/DxhZo
         dfh4zfg5GpeBrBd5+Rj432jKOdKs0SZyQUWSkgyMRza99mGyWVyuZmfwOifU+OcUiErM
         34cO5Svxp8NUhM0HdAffmFaQ94cFtzKFDoorB22UEbs2a6e4zXP0jeRhOhEvM3b93Fsp
         MFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737465161; x=1738069961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2x1boRC7Td3/KtEDErRciKOCKj4bZ9FvBbMmDACL5I=;
        b=R1Uv+4lxvmqIJ0R0nILVY2htOcJMnqGqCqoUWkfceSZ1fAqvrvTCTEt6qP3VmvEgfJ
         9sIAmMdW/S3X0VMcPcWkINt/POjeobE0hV2PhMQpbbS/pRjfGY6SHcITmWdpnqsOtzAH
         SLjxq84SH1o+t3aO+fkLjIp3oTa8CWJz9ZRVQ7Jn7U/f5N2R8MmWUZNK+rW689VFl4rL
         VjJMV8junFRKcRP35GYF20RWa4zjFbjKEdirrIjZ9RYE5poKoVVtbufU6jGwdUBiwqHA
         LJguyXeUPK8d6yLdIHh1jOtjQqP3SoCjJI4KLid3trxe6CZC/8UzYUS6wLPsepfdmxLn
         1Odw==
X-Forwarded-Encrypted: i=1; AJvYcCWeahj+P4layovNhQ12rscy9XiBqQJmJKL5cfr5B89a97M3eNWvA0c5HTF+mpUudKCAVG5Y/B1u46WPpUiKQMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM7IM8r56v8PtX6HV1hK/MJkESrjtbb3VSttcOuBQAYaDTZ9IH
	JHjCkc7pBrj8ty6xl47LL7R+fZDqgcb67yqwIBxIqCRH6004ohELZVyVp+QJNbI1piXM8LOdSPo
	flTuXuA==
X-Gm-Gg: ASbGnctGN3YiX4u6FcWdzyM2b23zw+xOElg5hSTfzGZ+osb5v0e/c4gZkMhhA8XHsNb
	/vX5Fv+hHiPfk2e2c67yf7MxPFX83OipNzYAOXjwgJrmq8yELnsrrnTUOK3O8R0+RkBQQf6QUZH
	ef8G6r3XL//s+y8gjzjVV+cEaLGjsJHUaEqvNxogVOaQ+PhUpzGxMr6M3vSBHKXLCtFoxJZEUCm
	HoLr4jxacQuppVEc8HKkNvJ626OrjVY+HETjbEUpUOGNkgNVOI0U80lxUjA/MRns7xclp+q5LLt
	Cw==
X-Google-Smtp-Source: AGHT+IFdpFJJy8M5KC3Tmd+NcjbDB60676AM8tQG4Ka5vOs+QjGJbreqWkLYn0gnkKmNKPe9eyz+tA==
X-Received: by 2002:a5d:5f51:0:b0:38a:624b:e619 with SMTP id ffacd0b85a97d-38bf59e2019mr18759407f8f.43.1737465161465;
        Tue, 21 Jan 2025 05:12:41 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7527fd1sm241546295e9.31.2025.01.21.05.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 05:12:41 -0800 (PST)
Message-ID: <af478340-6f3f-48d7-b88a-7dd3fa7b8e51@linaro.org>
Date: Tue, 21 Jan 2025 15:12:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC design of device coredump collection on panic in Pstore
To: Kees Cook <keescook@chromium.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Cc: gregkh@linuxfoundation.org, tony.luck@intel.com, gpiccoli@igalia.com,
 johannes@sipsolutions.net, rafael@kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_shashim@quicinc.com, quic_pkondeti@quicinc.com
References: <1683561060-2197-1-git-send-email-quic_mojha@quicinc.com>
 <202305161353.0F771E0@keescook>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <202305161353.0F771E0@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/16/23 23:55, Kees Cook wrote:
> On Mon, May 08, 2023 at 09:21:00PM +0530, Mukesh Ojha wrote:
>> 1. Device_coredump allocates some configurable contigous memory that can be controlled
>>    via CONFIG or bootargs and later registers for panic notifiers.
>> 2. Notifier gets added.
>> 3. Pstore adds device_coredump as its front-end via dumper registration similar
>>    to kmsg being dump today.
>> 4. Successful registration of dumper.
>> 5. A device driver(A-Z) can register their buffer to be dumped as part of panic.
>> 6. buffer gets added to the dump list.
>> 7. Panic occurs.
>> 8. iterate over registered drivers and copy their dump list to its own memory and if
>>    it crosses device core dump memory log an error stop iterating.
>> 9. Similar to devcore_dump() inline with kmsg_dump()
>> 10.Copy the content to pstore region and this could be elf or raw binary that can be
>>    discussed.
> 
> Yeah, I think having something like the panic dump handlers for
> driver-specific data sounds like a fine idea (as long as we have actual
> users of such an interface).
> 
> I think it would be easy to add another front-end to pstore (via the
> enums, etc), and expose it via a new template filename in the pstorefs.
> 

Hello Kees,

Currently I am working to get a similar design on Pstore as described by
Mukesh, with some differences.
I want to be able to register memory areas into Pstore, not by doing a
copy, just by registering via a new API (as a frontend, area pointer and
size). Further, these memory areas would be registered to a new type of
zone inside pstore/zone called directly mapped zone, and then registered
to any kind of backend that would support it. The backend would then
decide what to do with the memory area, have it ready in a list for a
panic case, hangup, or hardware fault; or something else.
This implementation would avoid memory copy operations, memory
reservations, and dependency to a panic handler being run. It would work
in multiple scenarios, not just when the kernel is being able to run a
panic handler.
Further, the data can be extracted either by JTAG, firmware, remote
processor or any other solution, including dedicated storage, shared
memory. One could then use it to construct a coredump or specific dump
information.
Having different memory areas being registered has the advantage of
being flexible and small, ranging from nothing to a full kernel memory
range.

What do you think about this approach ? Do you see it working like this ?

Thank you for your suggestions,
Eugen
