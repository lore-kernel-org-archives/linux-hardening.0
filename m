Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257415B11D
	for <linux-hardening@vger.kernel.org>; Tue,  2 Jul 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937116; cv=none; b=OpyjieNIJTS+qpvS2Eadn1YTkYGH91/nJm961+6doBnRFm8lZmQs36mKttat0XP/HwV2Tb1G6mlmGfWx+UodQBbSRqfffDMYJ3pvcGWn34rtuhW1Wov5mT7BfZbpq+eacw6YUnmqO5x6DS/ZR35k3C0DbxMyVTghxh2PQG+rkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937116; c=relaxed/simple;
	bh=AgE9FQGxGJLTJVWx55pmmSppZoMtGlA6Xq23h+emmxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2xGN3QYvoItROnMwXdRiqYT1vjwNbzP9ydxs8DehIdg3Y6acBQW6T5/QPMJ+Zf07wTFXaO/2QkzitYW0UZAriK2zmWhxapLFvNxpE06fOyGFLqhat6it4JLcwP2TQ9jfITUOSxovip+wZxQbk4zvK/gW0VgnJQmAtQ5fh8GU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ir52Gvz2; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ir52Gvz2"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f3d4a92857so11346739f.3
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jul 2024 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719937114; x=1720541914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f++KokYJIsMEcn6psVzWi3mhtO0eFnkLSGycni+7ewA=;
        b=Ir52Gvz2vnCk2m95LUZoeve/FIGcE1wNZ0PxZw4/SfC8couEJI4TMAsGg7ndIaelWZ
         iUDBe8Fnek95l7Z1w83wA15Ka/vodZXCtdBll2fMA8eSsr1zrRntHpYFlwHXT8tNQcuG
         eXMWI5NjZQvG6OOqXxCkmc3+H2Xdj7UZwCjjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719937114; x=1720541914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f++KokYJIsMEcn6psVzWi3mhtO0eFnkLSGycni+7ewA=;
        b=OkeTRIBBRVeeRzvieeISX0QPN6plEf3LK+Vbfu8C8LVz6c+enMfzAQ7ccG5NERBWqZ
         i4RibiXpGNovekKummGdTPr+qcPhqX+qGrtyzXSWeB04phR0QWXSFsMrc1CkZKsgMD3b
         4C9m6qOVLbf4oRXkKN+snFkvd5mbic3NiA1E7MySCuXEyBI1R8T2EfiXHKAhzdUwf62A
         j/c6QVq2zWNDjlcR1socfBmVNhhNR35uQGEPcOcrSfEutBXbwfSmRUN+ULG+LgE9A4Ru
         6VePAG6efehChI5c90nDeCPTnBV/bKX8itVKeqf5Jrkslzu+G6hvhZVv8wUR+jjwr48a
         j8Eg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Bm3IRvRf4ec7kRml1pHSIM/aGad19szGbjxKWP/T5SzPiU9PhVez9Wz2pQN9Ytwf+cUjBhEyFnjJRhuPgPpteGBvMaZwVoql7WRLrOYm
X-Gm-Message-State: AOJu0Yw9L1GQT137DYz+02DQB1bb3aFoo5Cz96LTZQiidY/ykCn9cpIj
	fGXBtVlBMqdNatXGiUMFESCr3KzXhwIjKAHgPBwJOZgWNYj3koIeyglmaCxHCeA=
X-Google-Smtp-Source: AGHT+IHZnMx5g9NW1e1RoZwZPcbUtmjlUGCxfhAaVxw/3os/XLw3MU5JXoUSSBLT0QRg8QjaO0HmOQ==
X-Received: by 2002:a05:6602:42c5:b0:7eb:69ec:43f2 with SMTP id ca18e2360f4ac-7f62ee5deaemr843037239f.1.1719937114541;
        Tue, 02 Jul 2024 09:18:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73f90cebsm2845555173.93.2024.07.02.09.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:18:34 -0700 (PDT)
Message-ID: <3298ef84-0404-4608-9e7a-887d8e30a5cd@linuxfoundation.org>
Date: Tue, 2 Jul 2024 10:18:33 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kunit/usercopy: Disable testing on !CONFIG_MMU
To: Kees Cook <kees@kernel.org>
Cc: Rae Moar <rmoar@google.com>, kernel test robot <lkp@intel.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619202511.it.861-kees@kernel.org>
 <CA+GJov5ZpFxKxK44SAb_B8SzWUF9uQV13A8BcVPijo0CV0mStg@mail.gmail.com>
 <202406271005.4E767DAE@keescook>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202406271005.4E767DAE@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/24 11:07, Kees Cook wrote:
> Hi Shuah,
> 
> Can you please add this to your -next tree since it fixes test failures
> on non-MMU systems, after commit cf6219ee889f ("usercopy: Convert
> test_user_copy to KUnit test").
> 

Applied to linux-kselftest kunit branch for next.

thanks,
-- Shuah


