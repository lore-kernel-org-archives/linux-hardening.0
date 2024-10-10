Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8184198831
	for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582944; cv=none; b=iMbR1yt7VrQEFZP79X+Pq4CUzLTrKC9yuT6k1NSlxP2NDFGuZ9VYgFUjs5aFNqkP62mLGA3txeGt2GjqQge5HrcMFhPKav734LPV3UlXc+NFWhB9It9fdcYktXrUK4+ALxotxqUXjw8je0cg8i6anw8VMywcOKkHnubCXhmOqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582944; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rUgOkSXkDP6WzljmWkI9wu/8TIOChpT+4n8ELFBh6bfn5GSlvp3AEJTjPGY3jcTA0vqc4RhP+WKqj9WEyYUL7HxawSF+GMRsJtJowO/uqH2nYo935hQdn8pbsInWus7CdOCTupckwdTY2nXpBBMbq1AHfe4Qi2uLWWu2Cr1zvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5dS2KVa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5dS2KVa"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71def8af0d9so77020b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582942; x=1729187742; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=R5dS2KVaVxfWzm7GHgl/3fUm5jSumEjxl61Y4wL7VE6LugMVInFls0d12IPjnLXsDs
         Zt/+bCsnj2mtXShjqrq9RVFGoZmg4+suW0q499WI1HY2WqwF/nw8t7Mdj36DNwiELo94
         jbx5WtQozc0dtKJR+ryzHI5RCE/AAuuyIkvQPha23o5TS471/H383kEkaojceC7ayXEv
         2OyFw70q3YuV+h58FgXfhMMWIKh5QZnR3aPkKVfs7T0Oghgq9Doe6sZR5MVx6R6CjEgO
         ufiAEw2nkQy7aN3275viPzqHLQ937XO1rk0e0mZPMJNszVsAPBPZdLCoMaX/6RxN2Kkj
         o86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582942; x=1729187742;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=XSUjbSrXwCjNyif2fRQUShCUxVycmi8+CehZu2NGW/bHfloLXY++c9EKgFdK4SGuA+
         vKMGpIHYn8msYXGq/+6n+0Lf5FbCJZ+tcFQ3XRLSQk25KjFG0Q4SVs/c47+nv6ZPgife
         QTWB1FsD3yTB/bE9/DY+iOq580P6xvgBYar3xhHSg02tbMwiLpQ0GqBw8WDWrzscHfph
         Isq2PAyZgweBsaKpk2QMmmErhywsbc62hvABcuqjWUmNaIaYXyUAtfffHF0dTHPciI78
         i4qphfie2dN9ovGpKAYxxd5geZuwsBN0fidpCeGymjALyVbVZwdw5Wkg568FIbpF2Hnf
         qvUg==
X-Gm-Message-State: AOJu0YzEb4CQINdOG9HJmFhuLWknldI6KlcvlGEhXE+MQnvGz0L8cZP/
	wx42aGC4LLHiPU7Z5ly6PwRMjq4Gcii8uOFv4cUdc11DZGSa9r0KikW/oVUB
X-Google-Smtp-Source: AGHT+IGYTG33enErRjzQCnrWmZb4sVuZ70gHTMrrJP7h2jFKhUaPrQBuW8YveTM5ZPaPmmZcJ7viiw==
X-Received: by 2002:a05:6a00:2d05:b0:714:1bcf:adbe with SMTP id d2e1a72fcca58-71e1daa8177mr4883095b3a.0.1728582942251;
        Thu, 10 Oct 2024 10:55:42 -0700 (PDT)
Received: from ?IPV6:2601:204:df00:9cd0:290d:e8e:18ee:9ae5? ([2601:204:df00:9cd0:290d:e8e:18ee:9ae5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab105f9sm1285655b3a.216.2024.10.10.10.55.41
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 10:55:41 -0700 (PDT)
Message-ID: <2dd541a7-1311-4a7f-ab5a-cd01b1f92ca4@gmail.com>
Date: Thu, 10 Oct 2024 10:55:40 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-hardening@vger.kernel.org
From: Atul Raut <rauji.arm@gmail.com>
Subject: subscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


