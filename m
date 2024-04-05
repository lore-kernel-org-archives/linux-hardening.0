Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843717106F
	for <linux-hardening@vger.kernel.org>; Fri,  5 Apr 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333285; cv=none; b=Gf/eImbml0qQ+agSLfmXIk7kTBPrRXiB+9IGc4Xx8YafIL7paP7QqjKV9PXoh0uehFl8pypwDQC2lJCY0ANVU0q25tXfxPfz7NshmF3SqgLaqOCDZsHKW0RKa+/N9xXKxjJ75sfV4bjPYh/crYCQugOxl6M4zGh8q79Q1bcepyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333285; c=relaxed/simple;
	bh=WQf37KnE8UstSt4WJHEZVKafftMROgs9kzOlz+UeEzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iU9xSc2Ph05tCbrbBrj3eagAsCqlnmxlqWYp3UFa9kOzRQ1fEB0Ijr9XXxb9kRgzWiJJ5Ec/uW00B84CXyV8HgEKgTDybzvJicMj1TY3sMINFUWFNi5tWEefOfttLl4KRPXxegOim5zZ+sqkdUxzfeKcVwJL610sViAGn8Ay7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RF1P1tAq; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RF1P1tAq"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c86e6f649aso23015039f.0
        for <linux-hardening@vger.kernel.org>; Fri, 05 Apr 2024 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712333283; x=1712938083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAuKDU6QiZ6ML3XGubjP2fNWyg1GAOwTBQh+lV89r38=;
        b=RF1P1tAqP3quLAouu2FwQVEKMZfuTL/RhbhOTdyP7oTf3gFptlw/NVwiayTL9e2JgE
         Uk5xCIZssSK6EvgKVWsChs3tfpMRfspjYJqtKqKl4iHHLDiY5viu6FVIaiMcr4D9wkuF
         ON7QY9G+UxHZZWqbwZbrWIXqrpsywHPYczIOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333283; x=1712938083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAuKDU6QiZ6ML3XGubjP2fNWyg1GAOwTBQh+lV89r38=;
        b=axTVjgHD5qjX0qI1kMxVVb7QILRvVW9g+Wjo1WBhcYZ6Hm7s/YVWclyv78OUL4CrY9
         7LqqlzgdTCBl36VMKX+b1NKuchWNON7YhEhpkgObNzIUo6wH7if9Ec515VkG8qOzUr6c
         DbEX5IVh/73/vX86AA/9R8c7k+wABXUS9Edib74YsY2440HXzNc5nh+YGoS2bSJ8w4iV
         Ys+56PGwGeVU9/TEJRiElid3YoSs/z6fC+3RaS8lXxp8jWz+I7FmkTNGTqhzy3u26wKU
         WoRaUpOyCBpguBkSUgHtNUBLkYzr319BMQqQVEQJzh5RUZqXqa+TtLtjdFdL/1eGim6G
         6GWA==
X-Forwarded-Encrypted: i=1; AJvYcCXOyuQpeZ2szciK6GyxXrvKsETUo4AL94B7wMftwIbrG44bOMquVf7cpjv1YXhsA/LIOYCFK467DH+/y/Lb0y6Ia86mWk5ArbC/5GdDCDDY
X-Gm-Message-State: AOJu0YzLXJ1zFrxnDWgR56WdmMyv3Iq4t1/ooFLWkaC1rYRebcvvwCwq
	dLslUcc2cGZGBwL/A10yS4ZM+RkN1TUT7Amlj2VhD4Ss9k9i30lQ0UF9Za731xg=
X-Google-Smtp-Source: AGHT+IEFSBlsclA6e2FP+b8IjmZLWOus+sNYfoqoIt8htlDfnprRT5+aCUKOtOxFEmmqkr93Xto/Bw==
X-Received: by 2002:a05:6602:148:b0:7d0:bd2b:43ba with SMTP id v8-20020a056602014800b007d0bd2b43bamr1795873iot.0.1712333282821;
        Fri, 05 Apr 2024 09:08:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f4-20020a5edf04000000b007cc78dafb96sm578949ioq.7.2024.04.05.09.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 09:08:02 -0700 (PDT)
Message-ID: <60d96894-a146-4ebb-b6d0-e1988a048c64@linuxfoundation.org>
Date: Fri, 5 Apr 2024 10:08:00 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Handle faults in KUnit tests
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 James Morris <jamorris@linux.microsoft.com>,
 Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marco Pagani <marpagan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Thara Gopinath <tgopinath@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Zahra Tarkhani <ztarkhani@microsoft.com>,
 kvm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 x86@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240326095118.126696-1-mic@digikod.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240326095118.126696-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/26/24 03:51, Mickaël Salaün wrote:
> Hi,
> 
> This patch series teaches KUnit to handle kthread faults as errors, and
> it brings a few related fixes and improvements.
> 
> Shuah, everything should be OK now, could you please merge this series?

Please cc linux-kselftest and kunit mailing lists. You got the world cc'ed
except for the important ones. :)

thanks,
-- Shuah
