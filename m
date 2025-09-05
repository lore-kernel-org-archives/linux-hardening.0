Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6131E2882CC;
	Fri,  5 Sep 2025 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103081; cv=none; b=V34ZujFz1WXwlcNxnbrcCrZ/SGL6zco0+N/IYX2gT6O43mKdopsqJgPkvvJ4EVl12l8GBizJXBLeqdIyGB5nJkND/1IUDVK2/WuGXoZw6K12vtMr19IB4jXvgcZ4EA3JvjiRgy394CkVm7jDZNAwHf6rR1DWwfGX2ZwwwEF0Vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103081; c=relaxed/simple;
	bh=pt5FYmzAOX0vF1yNT2OYVBQB2qw2fcTAKGUx1LBYO5g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=AaIWarL7ApmUiFkZbT/JpLDIfco7bHepsqXZVuiN5vGBurWUu0P/IVb68bxNyev3VyAzF4tFaBggCf65iWm0fHK3Mcew+prUKs5nT9Ms3seM+zMaLoSIN6HAwiEtqkVv3wAW+2MhI7KlmExAunMw2eWv3+zQrnKavI5XmHVg8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b00a9989633so473335666b.0;
        Fri, 05 Sep 2025 13:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757103075; x=1757707875;
        h=content-transfer-encoding:subject:from:to:content-language:reply-to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CNeVBChpPSW3Zw9eLsrTWLPrHpK+4pxoexsckxOXIg=;
        b=EgbEOvCM4uR8q0QGxRGq3oby4ZPKKsFnk1IoKMvnt+SHs+orwC/fZM2xeLY6s053iY
         eOSy09b2JqIa1WEC1OohJeEQKx+fkrunckQLl8ilDYlGoVfgz6AzlodINb2QVCtqRUpX
         cQSivcKkIa7AzJLlcCJ/xe9rYVO14J5/hAvr08BROUsmJpI4CAywE+qmXjIyduhMbW2l
         Qbp8fScZYJf8kqK5beJP9gupGFfRpua5hMU8cL39QVzsqyiPNqsj6Yxd7HbhkaiDZbz4
         QwEOh3NFTBSu9y32DIG7wrYW+8Oe29hUWShWbQYaCTUc3v1RsUwp3InI7KAFVGX49+ce
         zHhw==
X-Forwarded-Encrypted: i=1; AJvYcCVwxHKDU48phP4wH8RaW/Y58FNd4zJmXg2CvdiKVwdb3a16idGFrCXo6xfdU9MRU+CgZ+tIaogOOCCI771a@vger.kernel.org, AJvYcCWoO+GVJ+0yS6trb1s3sjQ8LrUEBKumpw7PIoKxNHYo4eZpmVK0b7YgapJxgSUPYNGQQ4aTEHA064gxdX/HmcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDFeKApdukuqwPOy3ZKn6t1/GPkGZD8V1bDMuGzb8IRLF2X5V
	FW+q1ZRAoa8O5EDhiV9EsZLoTQZtiwWtE8oDmMDagNEPvE9EIl5W/fHSp5d16Q==
X-Gm-Gg: ASbGnctdKOx6tXuGroKbSo868yb6K+lMHgvKYp0eIKBYCbcR0MktjicOnciYQ0Dl0ej
	wI+84Dxv3DM2NcOIwe/REi0EVLzoPDmKHZpuu9PtTUDTTb7XnwlyNA0mv2fjfAHT0tqBZ92KGZj
	yY9tlPAqoYUPesqeOQifd+Ytf7qjasObtkkUXDDrKNOOAlRLaMzblJegRGUUqXtXgQ9yHSNGPJD
	FkGBzafYOBFMbQPTsSs5Ijl+c+94+Ncs1+mPhKCxWtCVYcoJJ5W4JbO77zQwQTnzEib3PcBklpN
	l5+zWfqYrbaoTLFjVgwNLjyii3r2DCt9F+8/IwOnk8z5HHUFoCL+pepOV2Jd7NJQ4DaXgD/lwid
	rW44yze+LRvsbick8Oa0=
X-Google-Smtp-Source: AGHT+IHr/h8LMAq4D6Xkb3rU4602VFMlDFz/n0CzfnHoJuGC8Nq2KZrbPHG1pdTWXy65B0JfSGCI+A==
X-Received: by 2002:a17:906:dc93:b0:b02:d867:b837 with SMTP id a640c23a62f3a-b0493084d31mr511388866b.7.1757103074299;
        Fri, 05 Sep 2025 13:11:14 -0700 (PDT)
Received: from [0.0.0.0] ([89.207.129.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04190700a4sm1471790666b.63.2025.09.05.13.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 13:11:13 -0700 (PDT)
Message-ID: <01d9ec74-27bb-4e41-9676-12ce028c503f@linux.com>
Date: Fri, 5 Sep 2025 23:11:10 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: alex.popov@linux.com
Content-Language: en-US
To: "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>, linux-hardening@vger.kernel.org,
 kasan-dev <kasan-dev@googlegroups.com>, Kees Cook <keescook@chromium.org>,
 Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>,
 Matteo Rizzo <matteorizzo@google.com>, Florent Revest <revest@google.com>,
 GONG Ruiqi <gongruiqi1@huawei.com>, Harry Yoo <harry.yoo@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
From: Alexander Popov <alex.popov@linux.com>
Subject: Slab allocator hardening and cross-cache attacks
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

I published the article "Kernel-hack-drill and a new approach to exploiting 
CVE-2024-50264 in the Linux kernel":
https://a13xp0p0v.github.io/2025/09/02/kernel-hack-drill-and-CVE-2024-50264.html

It's about exploiting CVE-2024-50264, a race condition in AF_VSOCK sockets that 
happens between the connect() system call and a POSIX signal, resulting in a 
use-after-free (UAF).

I chose Ubuntu Server 24.04 with OEM/HWE kernel as the target for my 
experiments. This kernel ships with kconfig options that neutralize naive heap 
spraying for UAF exploitation:
  - CONFIG_SLAB_BUCKETS=y, which creates a set of separate slab caches for 
allocations with user-controlled data;
  - CONFIG_RANDOM_KMALLOC_CACHES=y, which creates multiple copies of slab caches 
for normal kmalloc allocation and makes kmalloc randomly pick one based on code 
address.

I used my pet project kernel-hack-drill to learn how cross-cache attacks behave 
on the kernel with slab allocator hardening turned on. Kernel-hack-drill is an 
open-source project (published under GPL-3.0) that provides a testing 
environment for learning and experimenting with Linux kernel vulnerabilities, 
exploit primitives, and kernel hardening features:
https://github.com/a13xp0p0v/kernel-hack-drill

In kernel-hack-drill, I developed several prototypes that implement cross-cache 
and cross-allocator attacks. The article thoroughly describes the procedure I 
used to debug them.

After experimenting with kernel-hack-drill on Ubuntu Server 24.04, I found that 
CONFIG_RANDOM_KMALLOC_CACHES and CONFIG_SLAB_BUCKETS block naive UAF 
exploitation, yet they also make my cross-cache attacks completely stable. It 
looks like these allocator features give an attacker better control over the 
slab with vulnerable objects and reduce the noise from other objects. Would you 
agree?

It seems that, without a mitigation such as SLAB_VIRTUAL, the Linux kernel 
remains wide-open to cross-cache attacks.

Best regards,
Alexander
