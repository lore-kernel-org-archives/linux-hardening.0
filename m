Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B766944F
	for <linux-hardening@vger.kernel.org>; Sat,  3 Jan 2026 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767424786; cv=none; b=Jw3PVe0u0yi3oeSXzrQKSSYJ61okLCB7JNT+eHCjvsInfm7/tZLCfHxRZJ5gkE31Bugp3Gaw2+pU1g+pJCDtz3m7MHq4H0g/yOBU/C23HGP9lpLMeSXTT8ktlrJaPiQxAgMjhkOhIHscpKm+U2npsotRlBvbcNzGZNqM8QtNqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767424786; c=relaxed/simple;
	bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bYyCRnX8dxoZuMFGmc/0gNhTY8vYFohvUo51WbUA3/sCCNOZtmnffA8aIxV63L535I2Sj+f5t0WSqYQGcAr/bsaLtDoVblDQYIExCC35QnqmZl4cHlj5zGSF0/P8xj4o5F02uq4sw7Jcr4GYDmDXlV+Oggpu4j9CMIVHxP81AKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOWfE/Zs; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOWfE/Zs"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b553412a19bso11926378a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Jan 2026 23:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767424784; x=1768029584; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
        b=eOWfE/ZswvSGJHm76zvdhbyRK31bli4QuhgnjXGvBXBO7IYOtJqmQT09/+ak9vh+BC
         Zmhy9Kb/1Y8US/6wabnancZarxbgSSA3AYf9nb+sLaCSjCKNBV7XRYGfrNu/RjKNqSSL
         +BAf4yeIt7wPVPdTPOguQlK+Xmsw4PgCeUW/sdOGmHceCyUK0b1vKeiEDAglrCiv38Tn
         JXo6plf3I7r6Jbq0mTa/+jM+VPr8G9ilvw1OXyBxgueBq8u040Lwdli9SoRl2b7S0YOf
         J6OsCmfvny7uoUinF+qajKb0rz0QyVroO+O5/JyqwaxAW12EhM/b2HvSc9K4wpwJ4rok
         PExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767424784; x=1768029584;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
        b=pJ/tmXdC4Txcdj6s5vZ8IGwZAHOCzWhOmsUxgtoj5OPAOftriOdWG2mzuwPzH8oTrh
         2pmxyvDAHV08paEnNpeYkDI8U+Xv7oU2vUZP7TSxm6BWlUu1ZjtCHTZK+lKwS9+jVfDc
         z2pNaN2dkzviPfcePtaz8c5HuOv7S7lnZvAEktQd9b1NfIHdxgafTPGU3rylzcNGsoHq
         HiFEUXTEk+biZ8vhd3bfbC1p/gjIi2PEzBBsFWB8dc8D8KYPSpXgFD6d5/rk5LdNjL4R
         JWhj/VVOl/5aOSUgr4LxLJi2/HWNaEpFfC6sqhDfTn3X8ruQpB6BVs9CLoY5SlUoNfmt
         0NWA==
X-Gm-Message-State: AOJu0YypGXlNQQeUyHCGMLhlH+oi8a9d0wZSrer81YAnoWK6HNcMxGNF
	rMk9qY/QxZ1K2+NhpNoDC0BOBehGU+pql1OxRXWXb675Mh5RIQfhEU152M4hpW5j
X-Gm-Gg: AY/fxX71niybBFE/NzhzccRdu+hZ4Y4sokx486ImQIWUhHYSlAjidCuvQLp6k7j0Y9+
	kMtrTkd21Ffy1VK4mjuN7rOXkU1L9Z+aj2SEV2tiIxf24F6sR7sEjQpUKNHXZ/xlbBVJ4djmmz7
	uo+yblVhXUBrmtO9rYlwijZia0O8VtxsJj8rdIqWt1asPfAx6Gmclrn4oRwKmY58fF1rrAF6UZ3
	n66BTT35eXE38cecoVzEKzpBkhaz2Cm3R2bmDPukxlKipxmUn7KfmqgaRAqul4cctPl7YF+G2wX
	eHXUIBhAMv0Iv2Q9UYPNSwDmKuDHb9OuItCw5AOMzsfPiKYJcBemFXWvGM/VS66un4zzV8ArHd5
	2yen2UqDQuRe57Oz/CXARAk1KHDr8119lXuBO6avsPrDOYiYQVHZYO+hBLFx9QMBr2vFya6v4Ir
	w=
X-Google-Smtp-Source: AGHT+IEWoHsXSQFqJihev2Ct+VDuYL2xbfFoUEvUrJdsg0N03hBxoGfTWeFi08TAflX98E+byIyr+A==
X-Received: by 2002:a05:7301:430c:b0:2ab:ca55:b762 with SMTP id 5a478bee46e88-2b05ecd8d0cmr28677602eec.41.1767424784144;
        Fri, 02 Jan 2026 23:19:44 -0800 (PST)
Received: from fedora ([67.63.80.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e5csm3542245eec.32.2026.01.02.23.19.43
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 23:19:43 -0800 (PST)
Date: Sat, 3 Jan 2026 02:19:41 -0500
From: Brandon Durepo <bdurepo@gmail.com>
To: linux-hardening@vger.kernel.org
Subject: Subscribe
Message-ID: <aVjDDWFbXJP2sbs-@fedora>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Subscribe
