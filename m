Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562A737DEB4
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803530; cv=none; b=f4ZImaEckvtQETSbNO12Nw4jryyfhUXzbZFY+DzeN+wMKQcakAFb60OJKqr6XmwIb5q7WqN2UTvAe9dKKiShZPP7nl2WTAthO2WwhZzRzZ6+kxvi0KtszgCJccq1rQuHBtCpP9/pS1+ZXqGdRckLddN+PaQw9VKAxnlBOhEt3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803530; c=relaxed/simple;
	bh=Yy9ffFyUQrMoHL9PPRJCin8PWXKYYPQGhJMEL1e2/dE=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Td5U51eRCwNzvWqqeN3x/zNDLw7Z8JiVRMFWp82XdvkxG/gKG8/Ld6zujQ1CY/cU4LIIj9n9FrlxM4NveHKhTadta0TiLzhnLY9Db1NqSlx+e6VURV5xAikN5CglB3PHvNQVRedKXRXJDzmBpYJo0siyOXLKezhT77fN2hEtjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVSDMqpO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVSDMqpO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso53665675e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776803528; x=1777408328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgdqTgHQs39YBlGPhgIz2cayv1MZAobuOakT/pInMmA=;
        b=rVSDMqpOZgP00RqrUi1DWDxMNxBNhyh46BvSpD055LjB+Nu17TA+Qc+Xqh4K1V/mIf
         bHpHSo+Vi1G3zzZwaY2PWRywjW5K4/Vs32urVaU6wjvClr/2vtwYonBYAZUEKQPzSFh8
         vSuAGDbiKBle1huWrp6nmNOWtfbtR27smA0uzTL7m+EwHg5ul3JaDsmLd/x6NkNdOuaz
         xXQ794qwHYfSh5cfxTeqTOinQIL3Wxt1EyIehMnWmdlRJM7JxtsUAPHgE/4sPyl9itIN
         RkzswFk/44jE/i/Ft4Pi7YcZXYQ0eH4H68YzzS9K13gQyNxr+9dtdu7gL00ydqTZE7PX
         wN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803528; x=1777408328;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgdqTgHQs39YBlGPhgIz2cayv1MZAobuOakT/pInMmA=;
        b=O6MUTP+CFs1dn5zH2ea17Qb6St0zQlYSC7lckxgah09kuEFJFin/uN6Daokq3Gs4r8
         bbOfsTU3DVGuxT9vghVgHYzXrt5lJ7Qzkcyx6zyHNEEf/6d9VeH/G08+jTdqm3uFo4Ex
         xYExcq5f1hJkncQubichW5FSLaas2fSWiWk3GPP6MrjV2IYQZcr0Ajtz5HiO57eg73Rr
         Pd024VilcT9xnr6Ynj+38oXEMoPcEyXGU58Iq149FRO8TRtVFDQxdOmh2e03mbLZ4+KY
         W8wfD/9sxLVntFEw9D1ZDEa/et+3uBduJJL3QUlaITRE1wu7sRqvrB0wLCXtIrBla12q
         HqPg==
X-Forwarded-Encrypted: i=1; AFNElJ86kekF11cIeLVB2e2NajqgcEs3k4VD2Ryrmh7jcv1KIfAkNePq/O+SLtpmmU3MJ2nUh9KAaT5iE8l7H0tceUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71zxhx1OZDlU6yFMlJBxQ+wAu8c59yDFzVRZEOU+GuxlKyKnk
	AoxzvXmRO3WquXR3NUo4qVVNhqFzgnCTc0Ey0mX7JK+Oa3T6jJJsaC06
X-Gm-Gg: AeBDieubsrTkJqMCCgqTJkSbmzGD1SfuyUDMU3yZ+TIiJcDsk6ak9FBXDkO39D0h6vj
	hE6+YcoRBGpKZ8/YbPd1IzAAlTpmdu8AuJtMbubwx3agJceSPaYGibinokBseUozy2KQNKieYYM
	YQIwC1A30T7AlVsnARVBmGSMhWa3EtVwg84bHZtb8Q8BDkJKFjR/tM98wPa4bi9eyZmfF6C7V29
	bf+pkUnvYegWd97RPJozDv+vQL0LazzF9j6BjSsrSqQ5xIFCF5nUThRZU9WWRQk1GVDdckT10n5
	CrT4DH4xzNSGKKh3G8wXii+z47o4SL6jPYSTXn+3O+F9ujZ9s9gbyNMDOFxWiOeFRhFBjx3y+JA
	hsK+sIppg4NEsFxWlS6QKbadCWzhDCCgIi8t9DdkXKyp0iSKM307O439DWWry3DajhYTPRN67j+
	f+x1jSEXWHDHwLcUol6sS2Vd4ZK/0WXPgBYThEeNcheenZS6E=
X-Received: by 2002:a05:600c:4fd1:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-488fb782a04mr285161905e9.22.1776803527739;
        Tue, 21 Apr 2026 13:32:07 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:23ee:1cd8:1171:2646:73c1:cff8:b7c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm208716375e9.13.2026.04.21.13.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 13:32:07 -0700 (PDT)
Date: Tue, 21 Apr 2026 21:32:06 +0100
From: Josh Law <joshlaw48@gmail.com>
To: shuvampandey1@gmail.com
CC: James.Bottomley@HansenPartnership.com, akpm@linux-foundation.org,
 andy@kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/tests: add string_get_size() boundary tests
In-Reply-To: <177680283372.84187.11707577520741615468@gmail.com>
Message-ID: <AA9B2A7E-A88D-457C-8244-50087631B347@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Shuvam!

I see that there already is discussion going on around patches
like this (from your Link: fields)

So I am going to try and keep this
as low drama as possible 

Okay, the one thing I will say about this, is I particularly like
these tests. They are very very smart and "gnarly" :-)

Like for example, 

+	/* binary values stay in bytes until the 1 KiB boundary */
+	test_string_get_size_one(1000, 1, "1.00 kB", "1000 B");
+	test_string_get_size_one(1018, 1, "1.02 kB", "1018 B");
+	test_string_get_size_one(1023, 1, "1.02 kB", "1023 B");
+	test_string_get_size_one(1024, 1, "1.02 kB", "1.00 KiB");
+	test_string_get_size_one(1025, 1, "1.03 kB", "1.00 KiB");

That is a INCREDIBLY smart edge case.  (I probably wouldn't think of this)

Or even

+	/* binary rounding around 1000 KiB */
+	test_string_get_size_one(1023487, 1, "1.02 MB", "999 KiB");
+	test_string_get_size_one(1023488, 1, "1.02 MB", "1000 KiB");
+	test_string_get_size_one(1024000, 1, "1.02 MB", "1000 KiB");
+	test_string_get_size_one(1024511, 1, "1.02 MB", "1000 KiB");
+	test_string_get_size_one(1024512, 1, "1.02 MB", "1001 KiB");

Again, smart. I like these tests.


So, you (more) than deserve these tags, as I tested it too :) :

Reviewed-by: Josh Law <joshlaw48@gmail.com>
Tested-by: Josh Law <joshlaw48@gmail.com>
