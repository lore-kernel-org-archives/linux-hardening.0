Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD9232451;
	Tue, 14 Jan 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870601; cv=none; b=brsF3Qi7srzwFQDH9pZdpPeE1HhugDrsJ+uhd/odWNcnnB8/Q+1NmByjwaTsRV1pqPdXYf29ZQuBDMR6sUrBXhwEqi9vAry/eQW2nSIxoZPdE07YbpUtBD1w6LpM62R3fMM6mcQwiJnNO6v/6eeLnq2KtxI5Kn7a717Badrrqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870601; c=relaxed/simple;
	bh=QHLTitPy6r6GtpcJpsPME6nWx9+dH1gZdEw1vosaeJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmYcCu/nVnCtzoy4pgaSARanB3ZKhVCtrSPMunD5jc7OeADHxxqmlvTq/I1vJ/rZAIJaoBpAS3afkwdrWIRRr0uY4OmrvhSA6fyRLRpQhL4yMxR5/7/ONdGZ1P/588TrMuiziwt3CuU8IQgnPBuw/QzMtckCkdLY/prjjaRAijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT8uhiA4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT8uhiA4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161d4b820bso8560845ad.1;
        Tue, 14 Jan 2025 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736870599; x=1737475399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=du0ol062NoMGm23MxITUchO9/Z8lzAy0FNSBC2ZWwrc=;
        b=HT8uhiA44Up56fxqogz9FGs78SxotGC1VtxysDNoD89lEWcOBLgHzI/k/j/pmNGqGf
         3KWGFqVHnLy/nZeyWRYIeuSjepGEcJItvJ+uDncs+y6Vld9VWcVbJEsk1e60iYJvhzRs
         W6ZxK3tr+PSCzc1JZyZyTjZssd/AvoHzBug8luAwq+x6TQaKyVicxyxrfO9WxWd4KnGT
         d5oFEYv0SA2bjezCl08x0C1+ycuXETsZ5ErALHStEPHDPbljXQq5yA9dOzHqQ5R9NzxE
         9XuTepMsa4+canS62lW3DI/tDb7ECrRLx81CShwTbwhlMG6HiWwyO+Hb6sFj98enbI1I
         7d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736870599; x=1737475399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=du0ol062NoMGm23MxITUchO9/Z8lzAy0FNSBC2ZWwrc=;
        b=N61wTxXTCUK/sGGxr0dof9sZQarMHxoqR8CWZ11RdAubhOl1EpN70aawqoPobUdFzM
         BaYuEZ3fAn4VqQvbv2q2Id9uwUVlWw7d34GpY/9rPj7g0ZzjtGNgkPUPeaSH8jULQXaR
         UBsc7OcFqOOb3/y/kOalKKC07susFIOdOEodJYATSpIIswDQpLKQcBfWjEtKdBB6wsPw
         o9k9m6KnDEimwIaYe1T3itWyq2CnFD4n/cVlMrce8ZJBJUaO2KI/0PIDgiLsKIc14V8E
         NWZIuHMk60nGcMKp1o+kD9wusXIIga4fQTZODy82f/AdkgIju0S9oAR2pqlCffqQBMTo
         BDUw==
X-Forwarded-Encrypted: i=1; AJvYcCUC/0UADuFsdYqGW3XHodCkulToC0LAqeUjpvrJs1cg8a4VB4DrUErLm5kTV532Bro6+0efYS43rxkRU5Each0=@vger.kernel.org, AJvYcCVvHPVxPVt7aMaF5zZ+xB4pKXymuNLnTUKcH6JLrUjMW5ENE/sh2z21VlWDR7RzR+wAcI5x+/wgfU55lAjg@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZT3uZAJN8HtSERz/kPZZ7jpY16Z9uD0m39ui4izzJPAD3Ezr
	EqOo4eTP+qQaJLFqgox/p1r7NHRloHRKN3PBLmJKfE7L4Hj6Wnk2
X-Gm-Gg: ASbGncvWdl1SbpJzxieNIaJ9rrw20Uu7MOLClyt5VTQlaVgPDxbWk7HgDTC94eru4mp
	Q8dl0AlP4+U5soR39Y1/hCotcRFhX8jgBvHxkqqx1KzvXJDsOhAx/jHCztd2mOyrPl4/0mEIaeC
	hEVpsSYjwK12YJPBwVihhnIhZAimcuWCO+SFWFgynSXBADAHahbBnKMgq0OhowENWtWKBFxeozl
	6ttqx5olxCJoKAXDtr8GDupR3adyqA+J1M10LBPGPybLkr+s38IZVJS+IxZvsJIt3iKUpjRc8d1
	3UhOXavp9BHcFbFwozvOOGStPSQ+PA==
X-Google-Smtp-Source: AGHT+IFIOqLbMaopTmPlhxaTfsRdloworkDKFg5KO8mD3qNF/JRkdBzwNu+zzRndsQYM9E1nan5Ctw==
X-Received: by 2002:a17:902:f60e:b0:216:42fd:79d8 with SMTP id d9443c01a7336-21a83fd373emr154515295ad.12.1736870599289;
        Tue, 14 Jan 2025 08:03:19 -0800 (PST)
Received: from ?IPV6:2402:e280:214c:86:4de:6c26:6a11:901e? ([2402:e280:214c:86:4de:6c26:6a11:901e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f4d7sm68299575ad.10.2025.01.14.08.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 08:03:19 -0800 (PST)
Message-ID: <58751174-1dc4-4467-aed3-e387261dba78@gmail.com>
Date: Tue, 14 Jan 2025 21:33:16 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 linux-next 1/2] lib/string_choices: Rearrange functions
 in sorted order
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20241119021719.7659-1-prosunofficial@gmail.com>
 <20241119021719.7659-2-prosunofficial@gmail.com>
 <Z4ZZroWX80eQGMAT@lzaremba-mobl.ger.corp.intel.com>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <Z4ZZroWX80eQGMAT@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/01/25 18:03, Larysa Zaremba wrote:
> On Tue, Nov 19, 2024 at 07:47:18AM +0530, R Sundar wrote:
>> Rearrange misplaced functions in sorted order.
>>
>> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> 
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> This is a much-needed patch.
> 
> R Sundar,
> Can I pick it into my series in case it will not be accepted in the nearest
> future? (I do not promise this, but there is a chance)
> 
Hi,

Yes, Please.

Thanks.

Best Regards,
Sundar

>> ---
>>   include/linux/string_choices.h | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
>> index 120ca0f28e95..f3ba4f52ff26 100644
>> --- a/include/linux/string_choices.h
>> +++ b/include/linux/string_choices.h
>> @@ -41,23 +41,23 @@ static inline const char *str_high_low(bool v)
>>   }
>>   #define str_low_high(v)		str_high_low(!(v))
>>   
>> -static inline const char *str_read_write(bool v)
>> -{
>> -	return v ? "read" : "write";
>> -}
>> -#define str_write_read(v)		str_read_write(!(v))
>> -
>>   static inline const char *str_on_off(bool v)
>>   {
>>   	return v ? "on" : "off";
>>   }
>>   #define str_off_on(v)		str_on_off(!(v))
>>   
>> -static inline const char *str_yes_no(bool v)
>> +static inline const char *str_read_write(bool v)
>>   {
>> -	return v ? "yes" : "no";
>> +	return v ? "read" : "write";
>>   }
>> -#define str_no_yes(v)		str_yes_no(!(v))
>> +#define str_write_read(v)		str_read_write(!(v))
>> +
>> +static inline const char *str_true_false(bool v)
>> +{
>> +	return v ? "true" : "false";
>> +}
>> +#define str_false_true(v)		str_true_false(!(v))
>>   
>>   static inline const char *str_up_down(bool v)
>>   {
>> @@ -65,11 +65,11 @@ static inline const char *str_up_down(bool v)
>>   }
>>   #define str_down_up(v)		str_up_down(!(v))
>>   
>> -static inline const char *str_true_false(bool v)
>> +static inline const char *str_yes_no(bool v)
>>   {
>> -	return v ? "true" : "false";
>> +	return v ? "yes" : "no";
>>   }
>> -#define str_false_true(v)		str_true_false(!(v))
>> +#define str_no_yes(v)		str_yes_no(!(v))
>>   
>>   /**
>>    * str_plural - Return the simple pluralization based on English counts
>> -- 
>> 2.34.1
>>

