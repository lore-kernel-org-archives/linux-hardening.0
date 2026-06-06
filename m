Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58D2E62B5
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780767863; cv=none; b=P1f1AC0BmquIN6BcCcbJaGH5H+NUu2ZmCnCOPP7ybEqY7a8Sz7O+j12uXU84M+qWBTQMPdT6RlKCgoXmBhsIGDya6aXeF/rpBWCXMS2lXIDrf7KRqmJsWUWtUrLMjf/qZQtYm9f0Tzobkc8TE36vI6BkAY9EVzHCM3ERlRgLjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780767863; c=relaxed/simple;
	bh=Y8/jaItJY7WDpAzUWHVQcS+f43pWTZf1MJey3/FU7xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzMSfJkDLt3Yn7FQJUXFkNDDrZkjLK4hNW1QgqwXzr8T/RJ5k39+McOxixg3zE8hKzLfQDW2UzBQjILhaShspPJtr7wZv1FMyhuRZS7fPQy8JEy/NTOyQ0035pBXmOET43CSVeTTlxaHfrchpt876AJs0Hp7icVyq0d2aO2taFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgNExdDL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgNExdDL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so1980295f8f.1
        for <linux-hardening@vger.kernel.org>; Sat, 06 Jun 2026 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780767860; x=1781372660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8/jaItJY7WDpAzUWHVQcS+f43pWTZf1MJey3/FU7xc=;
        b=QgNExdDLrB7AawfoBrcJUlgGBi3hn5nkbb+yiiL1AWEjJEUAdAph1JhmxMYelUr+LE
         nnfpLAdiQ+FuOP4pQ04q3h64qK9uAukFjH15nESXZGKrcbKmGWKRW+ot119D4+z93XL9
         Nqj4ebzWmduLxyentO9Us5NhN/xuHxSIBTDVpdKyxGAQn2qAJKxfGxJNiXoaMvrUdHDU
         ooXrkc64fqYpL/Hq8s+MW4lonNbR8Vl67tJkxExcu+n6Bm/pxRIUGpkgC9wpVsl8ewAY
         daKVDvYbh2ii5Z1VfmzBvZTxePSOvVpYtwJirCgF0k0D9FxyNaxxLkJNxwR1UBmXllzJ
         fntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780767860; x=1781372660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8/jaItJY7WDpAzUWHVQcS+f43pWTZf1MJey3/FU7xc=;
        b=nrxMqLo4vYCrhuTaSbicW7TA8p5Fmhg5MbFCGe5D5UHevh6ByN+kJHQsxgynfkuvYe
         Gh+9Ud3fmJ9oLyu0p/+SGF3RjSSMeCzQWA3I38lQKM5ZLPpFoHsXGKcFyNusVypmVDvS
         7f3w7B3BjEvFw5qrQ+L+vnkpiCHrKRFJb//CMbU3Ly/qTnBD0JAv/tWmKr8TII924TCW
         5q1KYynihUaIadJGgfn55sBrp+jDv5hImsGzYVlBPsK+79+I50z0kbAeYOG76TkPVy9F
         9lzggprLkv0WhLSwjWHcWFs7b+j4WbdRQoJNWVXyCli39U7POIDB4IKEfqP6nYr0XZoj
         Oz6A==
X-Forwarded-Encrypted: i=1; AFNElJ9qTD5io38wjnV7SvLq62d6f2AZWxst3K01OO3SbV/ddjltfyu1mtWhQGcZs/MGBe2cjwKeDYwYVDt2CCiJCYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFrKMwLRpxZA4uTvJTLAxsErIrQTdkP5xKivtq/l0WvnbtNQk
	a/LN1tFFGVymDthITiFlfcRBnPIF3olt7uvqr5aUBDedc20H8A+/9Hs=
X-Gm-Gg: Acq92OGBS/0gCcv0ABRFJHsNWYf+Hy6d39xlOkNUoUjtl7JiiCTH9+2HXrHSWN3mTHd
	NoBtebQPACxCm4YkLjSFqePdEWdtOMYmPG0VRdqwfeUP96oXodU71osmEldtCa15JWJBb+AjYch
	qZ7HJkVsTh3ADhcQxJm5cP1KWj2Y4atUpsiLSgNzB2NoxFS/8RBY7KJ9Psc9iPAZbIkX+kLmu1t
	qHxBaGYdZIIH5RbYPYTOYYxT5leleFwPKi5CmebC/k1pW6q6SwCdatEve6TRfFUpxp1RHJrGAXo
	7G0llXGjglraFk/mgkJZAE3TWInXPjEz8a0iLt/pqlMywmnSaIExk0duqsZ6dSHbRQ9udnkHNGJ
	N6bRIP0I4UeZzzwyw/CyJEzHB0Ii+y37LrC9gBmjdk1IKGL9EV5VJmr5l+nvb/sqNb2hk0hkSqC
	OCXoJHCe1PrGm7nXer8Nw0l/kzJRflusRR/4ntAGGBqlVKxoSAqJl5na1l81LdzBBqWR1pfrrS0
	Y5raqEaLA1WrCyZKNmOGY83vhSKlX89fuLW2K2CGg==
X-Received: by 2002:a05:600c:524a:b0:490:b11f:2560 with SMTP id 5b1f17b1804b1-490c256f131mr157979935e9.9.1780767860114;
        Sat, 06 Jun 2026 10:44:20 -0700 (PDT)
Received: from hp-ubuntu.. ([41.248.186.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d5d2b4sm127326035e9.2.2026.06.06.10.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:44:19 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/mm: document slab cache isolation with SLAB_NO_MERGE
Date: Sat,  6 Jun 2026 18:44:12 +0100
Message-ID: <20260606174412.4843-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <874ijfvec2.fsf@trenco.lwn.net>
References: <20260606155856.15548-1-med08elkadiri@gmail.com> <874ijfvec2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thank you for the review.

Yes, I used AI assistance in writing this document. The technical
content reflects my understanding from working on the SLAB_NO_MERGE
patches (one of which was Acked by Vlastimil Babka), but I failed to
follow the documentation markup conventions.

I will fix the markup and resubmit as v2.

Mohammed
