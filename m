Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F97137E;
	Sat, 19 Oct 2024 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729304039; cv=none; b=i8m876aBz+84d1mwHxF15H1oCZ0TUhijLWhxBJlhvtbql7dnNEzKnJAySl3LwkJY4laZEMbzvjGjBS0ZuCBQbrlja3naAtofJdTJ8NdezWL5EUvyH+cZdjWQ8Gl8YQiO9m7BW0V1EN6YAOkTcmCJxQmrZtlVDnmVbM913sx2zlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729304039; c=relaxed/simple;
	bh=hex4J5I3lxjPeyOhVGg+WdoyiHo81glgLww98b4OQmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HWAPm1rfhVfteGQwCgW76UFR/UftzQCXjISuqOvdb+v3g0XuU/6VD+C56fQIeFv5x2HDx4ZJxRrDgVRpUu69piLfaStYjVM5IMWXi54wOfiE2wGdhowfDJEgP2oJFClTSigN7qr6V6rhElBfDYSh0tEzilfuXtXP2bOvEdIJmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqOWwoio; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqOWwoio"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea80863f12so1341700a12.1;
        Fri, 18 Oct 2024 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729304037; x=1729908837; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3OBhiG6hpLJQg9Qq6gvNx63LfPAP30OwnCahO0IdDw=;
        b=mqOWwoiok6/Rw6mBaUIhW/sKOc8WyaXUwFVi1aWjCtb5dAc5XuyR+ImGQyVwzSnmgh
         +TI3ANoX+W/mexGbNx1Ke2Hh4swiPktEXLMw6DJWxanWZJZoslqopp2nyghe4AyKvXXH
         jg2b/zrAEYoaUEd3JI0Vl1xamgP9eMUy4GkrKau3c3vWYrdcCi7a1rN0NJXlPEYAlEat
         xfGZePd+mUXKYFY8N/xjDWrJzn6I9u4ob8eol2uV/VthblsqOX0N1NY0ncYbIcnwnovW
         qS1SbW5sxVYQ0qBK04RJ/fu5f19ZBhpS67SXSzP4fi+E4m/lEBMc4p0ZHG7HOhYw6nUD
         aX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729304037; x=1729908837;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3OBhiG6hpLJQg9Qq6gvNx63LfPAP30OwnCahO0IdDw=;
        b=gzvQAToM1bL6eYKLtAIOc42KPSRNiSvc6dT4zB98MjvnV2vv1ho2YHkr7os67PHRRV
         nIXwHyo3CaoXE8ichskKvHa8kqcBDVikr7GIrai+iP+n7KBui5TXYYd8cZjwnfGSXFQH
         x0AJGgh7wM/rHmuKvE0YOuQQkcTeXAFzUj2GcAAv/8y17Wf7m/KiuajSzfLHMbAKKIQf
         wob0GDJCZ46LQ5qSxJ704EeQ0MIA5s1I9OKVzAgDrVGXQAOVAB/nxzSKsXoaldyT9GlM
         rIjXwF+5oGse+PWxeXstaPz51TqrbTaD2SPGKmUeMfJ6Ilx+ztqZN2fqaASDtE5hyRZV
         C0jA==
X-Forwarded-Encrypted: i=1; AJvYcCUotwf8NdOd2XwJSBYn0nbdlhES1TEtrpdsddfXbAD6ZUUGe5hg2HSW/KbrwWjWvaaNJZL4gHyA2IxWXlNq@vger.kernel.org, AJvYcCV58yUTCDsNQGE6ZdQfp9wChv5pzcgp38hvaI+vMwDMIZ8DZ5bJVV+kOgbUjikgchd1ozAqADHTr4QNhU+O1Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKpDSKKe654xHC0p2WpVAbF9UyJUoW82qSK51Vc+hDcq3kQUq
	ZBT2s4OOPp6cbhVGSMs8oRKqC2GfqmJiYbOAxWpHMnrmlsYSTqTC
X-Google-Smtp-Source: AGHT+IE4I/Iv1lLYcMF2ZZmIIaMutEWKICjcPsDAVtltpIWvp0LxjTcOiq0LVYwKdoAvk+M0c2j6qw==
X-Received: by 2002:a05:6a21:a4c1:b0:1d8:d6b6:94c6 with SMTP id adf61e73a8af0-1d92c4ad359mr6963538637.2.1729304036708;
        Fri, 18 Oct 2024 19:13:56 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311d59sm2229509b3a.16.2024.10.18.19.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 19:13:56 -0700 (PDT)
Date: Sat, 19 Oct 2024 15:13:49 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: paulo.miguel.almeida.rodenas@gmail.com, linux-hardening@vger.kernel.org
Subject: [PATCH][next] powerpc/ps3: replace open-coded sysfs_emit function
Message-ID: <ZxMV3YvSulJFZ8rk@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sysfs_emit() helper function should be used when formatting the value
to be returned to user space.

This patch replaces open-coded sysfs_emit() in sysfs .show() callbacks

Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 arch/powerpc/platforms/ps3/system-bus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index b9a7d9bae687..afbaabf182d0 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -453,10 +453,9 @@ static ssize_t modalias_show(struct device *_dev, struct device_attribute *a,
 	char *buf)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
-	int len = snprintf(buf, PAGE_SIZE, "ps3:%d:%d\n", dev->match_id,
-			   dev->match_sub_id);
 
-	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
+	return sysfs_emit(buf, "ps3:%d:%d\n", dev->match_id,
+			  dev->match_sub_id);
 }
 static DEVICE_ATTR_RO(modalias);
 
-- 
2.47.0

