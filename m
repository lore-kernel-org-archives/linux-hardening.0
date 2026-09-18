Received: from mail-pj2-f19.google.com (mail-pj2-f19.google.com [74.125.227.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130E4FB9B0
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743873; cv=none; b=L6/cD/Ld6T2uvSMnZTuwqAhevEVLSYL3dh9k1I2ZhAN6IvmE4WnAMTRTnpm/TaEC4Njh8aiau4ldQTdxqoy5lwZIPsOscpq/4i2meHIosHyakU3u8HHnTAxcSTRTbw3wyp7RwiW9VI6ZQuH1g3c/lkmmFltVg2GQGVilkyylW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743873; c=relaxed/simple;
	bh=hSYPaZd4QidUGUpkJDVqdSFkFz4HHsx9wagFErTa9e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/PrS8GhHMxK9N9+D5mPE1F6UWRk8Lb/seWjW4juADzySapaFjcr/fp2KZqhABCPo4DxyL0dC9FgjYUjq/lCgMJmoA0bbgFCGknOTPnQQCvreIEDjxLEw0ILIHQTMKNNIDQk7Yq4wujuEimOxv9aka3wh5K2B/ABYfzXSgcNwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmrDfjbB; arc=none smtp.client-ip=74.125.227.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmrDfjbB"
Received: by mail-pj2-f19.google.com with SMTP id d9443c01a7336-2db18fe433fso7364325ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789743871; x=1790348671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6oH5lMiBGio7Tl7op1uAmsvZkVfuae8o7zdbV+2icCs=;
        b=cmrDfjbB70iqh6q4unxNHbBj9Lz4keBtz1ja+QLJok8I6KZng7HhrPLxCpUeBBpOZJ
         asSMiso8120MdLzV8Nml8fh/s2hvmwyDNdogSq3b+HTtF53hNfIAfcrmUVgQ2o39+fDk
         af2/ra2mK5VsaIoePY1ynx9wEznrWh5w03feEnCauy3xwZ4xrSuYbavMsnwoxodIZEmT
         UxG/VgthQdEONWlwYCmEqgEyT7pi7WgyqtwkWYBLCvMg7EGFFBKVr1blqbIurwtdljmF
         8ugZTF/v8XVx4MKWUt+jVXNc6HgHgednG63rkXPiE0GKRIkZQkudutqYaxVecRmpY773
         bHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743871; x=1790348671;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oH5lMiBGio7Tl7op1uAmsvZkVfuae8o7zdbV+2icCs=;
        b=rY0c6c+SIImS2C0Ypem7bRyX8N5O24XkVHbrmT43OVKWiwFv7qnNguKv0HDovCAEyE
         3YYYAFQ4YPNJqpVr5fa6mQM6ChmnpvVZViMqvH2JfEgEd9pJ5RD1xhbUgrm7SJUxJUU5
         vBFlw9H9zh55j21m/fV/qBN3T1SVkvyESMw2FFIyVmeFAPyOKTwsqibyZVAPjSeJoEMw
         fZI+kNRkgRxIG6L+2OBh1Z2ntln/Ev5pdOz7KXgInqY2yMzRjUVr/gp8aw+/skAXYKVh
         G+GJYgYkjaQp3UZqMUoukgrGW08vj/Z7AYmfV9+nhcaQgeDKXFT9YUdYOFMhq0Er1Cch
         K1bQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2RhhOhHq4M6Iw3oVqxZgNehPss7iwf2IEuZeV1nEHEcNU//dgAI0uCRZNlUk+XAaf8rDUtwMT356dkt2aMCg=@vger.kernel.org
X-Gm-Message-State: AFuF++lajaX/IhbV0XJU4eahINJYgEV/21yd8OJ6rvQDuHRUidIFAw47
	7j7zTy/2Wdh8Qusux4ESGguyHuGvBg6u73orupqcSo0PBxB0zEw39MKC
X-Gm-Gg: AYBFou1ceAVyccEQNe+5oe7d3n+tGAftHTJO5HNhvUPtHGALwLqpUGh3iJ8bFSlYDrD
	e4ewC208Nf9ulwmPLu5gCYk0s0tvbFoOjLt7QC08Hm8xk0IQRR8uAiEt9QVWlTYxXAp7qdMOnrf
	9QT8uX0A7YWPn4kJctVfcakDs8ibUyYtzLTqOJdXneGZ3FxSmpGpojDJqyM09RKx0WoVGvGYv+r
	43+gxtTbWOaZvNFz7IdIwOcWmpCtZK2gOQN/ZatUFa8nzwfqRZdwZ/NYcZpiHXLi6qDls7nKpRi
	Ia3aBCd9WdIzeZEQCY9t9QU8tcQZ/UtVZhZJ3tsGP0W9S/dbxianM8ucA6K32XqqSBC1RvcLflI
	5HHxuZxS4MBElv3PSbqaBgb7YWvPB6soPuV08w9Cm1+C5n1vATyGfXWN5qXlUSMrF69mdlgY0rJ
	v3ClZyHtZoq1/6MmRQtABliTFS4UbvOB3WF3gmWSuVrIB0hqXjexB86D7rQbmJ0Rvb3rfh4+XZ0
	L8yrcjrnwstLOWgN/Gfn3U=
X-Received: by 2002:a17:902:f543:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2ddb1b097f4mr62517815ad.12.1789743870738;
        Fri, 18 Sep 2026 08:04:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb757adaasm10060625ad.48.2026.09.18.08.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:04:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 18 Sep 2026 08:04:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <kees@kernel.org>
Cc: Ed Brindley <kernel@maidavale.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Denis Pauk <pauk.denis@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: asus_wmi_sensors: Fix info[] allocation type
Message-ID: <39707657-7ff4-41e2-b324-92fc571a746f@roeck-us.net>
References: <20260917211332.i.711-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917211332.i.711-kees@kernel.org>

On Thu, Sep 17, 2026 at 02:13:33PM -0700, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type of "sensor_data->wmi.info[type]" is
> "const struct asus_wmi_sensor_info **", but the converted allocation
> type would be "const struct asus_wmi_sensor_info ***", as the size was
> taken from "*sensor_data->wmi.info", which is one level of indirection
> too many. Luckily both element types are pointers of the same size. Take
> the size from the element type of the assignment target.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> drivers/hwmon/asus_wmi_sensors.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Applied.

Thanks,
Guenter
