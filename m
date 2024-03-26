Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59671B47
	for <linux-hardening@vger.kernel.org>; Tue, 26 Mar 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485968; cv=none; b=KUepV1GNtmto/MW3Y8Cy1SdgL90c38Hz32SIBd7km7LIdXjIuPeDHN6kaeGvBCqZgg176Kul5WKAJBEX0RHx5+P5n14+B0Hj1zU7xtq27Ylof+AYzh501JIaW5Aw1EVGeK7h1JXNLiyWsYsVXNYRQ7tWqoZBdrAfHYQE3wYjVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485968; c=relaxed/simple;
	bh=uEDRqCJhhsVJuG1lHyDzprVktcDpniqReLT6wXFu5VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqSfPnFlOSt8Y4Kb9ussEylKxr13Ge1OJixFr+BbyHH/Ju80MdcLeEhCtVw6aNDEZOVZeLYAA9nDDYAXcrQakmtvg/Sh2Q1f4qITvEady/ROkY7i6CPJDd5TH0nN9sKlOT/QPZ2H/v27qHMVGk3sJGVIrXet+N0uBxqIm8I9ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PQ8q0PNr; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PQ8q0PNr"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cc5e664d52so66108039f.0
        for <linux-hardening@vger.kernel.org>; Tue, 26 Mar 2024 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711485963; x=1712090763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJxbjA701dwsdP2q2KPyD0sBjpjzuhiGe9ACSutvT/g=;
        b=PQ8q0PNrl10WPs9Ih0bUQJpFi/hUKbVwCdPK/gWb//ISl++RbF6ddE0edQJmODaYjh
         4O10XNOjPai9pPfDk/c7xqgTW/FkI5j81FV4RdTuF+CI/245D8BZXk0BTWJ3Ntw5uBIs
         05gNNf0AfLBU6WxBwjGpkn+y7uwU2wXdf/Ti4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485963; x=1712090763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJxbjA701dwsdP2q2KPyD0sBjpjzuhiGe9ACSutvT/g=;
        b=Wayp0pJNepKzGeJws/pPRhv4VOXo9CsLNfwatczk1kZXl083m9WjOCpfbsd5v6SwlE
         F38bMOA4qBymgoRJfAR4uloeux5Ocd0CC/MG+vODXRPeOibg8DCZyQ8Ib99hMI7T/euQ
         b44Ex103AmssfvGQg/DGP4Soa4CPKHyEFcH+rNosx17sEfHJyG4pXVfz+tl0543OOo7v
         rbUtCHCOV+irNuw9RDMEXMTQSxy8vthKzqjwOp3IwNSh4e+4p6tffGpE3H5Av63lA1qX
         hT9+5TojgzilH74FZyNLg7nSjyrUhr7XUlZdiBhEEBohiSeN0VpXEk/ajd8wjzLHDD2+
         aA4w==
X-Forwarded-Encrypted: i=1; AJvYcCVYDb20rImcLZgFHw9KfiKfy1Q4D0Po5ZA5ATuQNvioxhnAL7n+/SnTDqKSffrsKkEZEWqaByzsSwig/71odp4nySbBtzgWX7hbRrnL9MqZ
X-Gm-Message-State: AOJu0Yzo8TQj3rPdcLzyGOuqDfk7d5bhjzYl9iUXRE94/PoevxYUZbV9
	lJeHivaVAecgrJUS48kL+0nHCM9VHW9njPFSacwvKaMKwF8pW/xqBCSXLRDQFxM=
X-Google-Smtp-Source: AGHT+IFnLbenFAcC5hMRhgWI6w1Lf3ppFDQZj2WhN2OHomt36Dv64FHl5a4Au0OxgKw4A7fv4kfWNA==
X-Received: by 2002:a05:6e02:1fea:b0:368:a043:4a26 with SMTP id dt10-20020a056e021fea00b00368a0434a26mr3689428ilb.3.1711485963436;
        Tue, 26 Mar 2024 13:46:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id z9-20020a92bf09000000b003687fba7541sm2287115ilh.79.2024.03.26.13.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:46:03 -0700 (PDT)
Message-ID: <fa109cff-5326-4f94-aa3b-d83827d5f968@linuxfoundation.org>
Date: Tue, 26 Mar 2024 14:46:02 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/exec: execveat: Improve debug reporting
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240313185606.work.073-kees@kernel.org>
 <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 02:54, Muhammad Usama Anjum wrote:
> On 3/13/24 11:56 PM, Kees Cook wrote:
>> Children processes were reporting their status, duplicating the
>> parent's. Remove that, and add some additional details about the test
>> execution.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kselftest@vger.kernel.org
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 

Applied to linux-kselftest fixes for the next rc.

thanks,
-- Shuah

