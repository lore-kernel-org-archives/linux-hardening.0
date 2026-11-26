Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695300;
	b=fSARxBvq5vHgPUSPY1tnR7Pjna7Sjb1aD4D4phGN4r6CkHu3+VXuSsqAKIryk3a3G9Qx
	 nV1MGEXPxjz4pin0a7IAaCovJKSbFmojZLgv9a6tIH7h5IYszQFclS2Qtrr31MOnN3Jkn
	 QHRwQDYPjYHHHjxsjt+Fauwn7PD3fCtmCX7L9PzPzD+b3mI9lTJWL9yugrWo3tvr8GguK
	 OCrrKFFUeMFtwRb7SaDIrZaVH5MTHDjkSrVJNAnqaHNshlcbxp9k1U0DX8+L7aCcfH8Hm
	 XUEhyNwZLQYRbGgSM0yzCuqUQ4lIk7k9PZm9pcUQ3qkfFLpjU555MgxKM8AAPnTF+mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=XCVZxwPpgvCRm6fFYl5Jvfibq2GfrDdmfWffaFs4sZg=;
	b=VjMd4yZjmdf6GRFRAzGTqjZfRNv+cWA3cJGN4ozdn3rpYkK6OLpRQFA9l5fwvxNrBXGP
	 secLqk9u+t1jtZv75/ht/sESKjaKBWZUzYgagDynIevKjOSlVAFIamU+4K0dVJn3Q23Kf
	 VGkVDemwoJLGelcwrFv5Umamzkbeuo4/9f0BWXvaulrl7IXeoAQVR5KpuFlK0k2KtEbvZ
	 rruvoxpWdDeX5e4iChH75hxjZHGodWpBXunj5vLvhAjFi5Q7DZhFpllNGz/uV2UG+xzS7
	 Pm4JyWJiIT3SrZTxFxBoZrja2kqdxGqsS7xn9+QhG0S4Ihxc+wOskwQ8ZONH8cvoCGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qke+h4B7;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23DC606A31C
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 12:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C23DC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qke+h4B7
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38644aedba1so10393428eec.0
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 04:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695299; x=1796300099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XCVZxwPpgvCRm6fFYl5Jvfibq2GfrDdmfWffaFs4sZg=;
        b=qke+h4B7beZrYv8v3CWSrYutsRK1ufA/ye++MY5GstVXEPad1y2Wdnwe0m5SR8HQ4Y
         rLO9tLA5FP2/433U3UTBDlJHOBIjq77WCJwOkOdte69VNYxCy2zMAaJ9XoZ7ESZrZsIX
         VtTUXVPhUdytgeCbqMkNT1hVT/4LNjptJXIwvLyhvI1fkFm3cyYLjl7edZvA5pZaqWbq
         AsNZWeOPwFZ8eo0Xapc9DACJmq8qx4ftXs6KPpbJ4zJNG6UVviTx85CRHG0DFEwf9QUo
         H5kZKUDpfGXwNKFo5ZjBnm1jdIx0jMAXa8TSwUGtOM8P0q3SWpeQdwHQlvhDROnEkkbu
         ClQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695299; x=1796300099;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCVZxwPpgvCRm6fFYl5Jvfibq2GfrDdmfWffaFs4sZg=;
        b=bXgKg3pw4eGaZLhO23WIWJFOH7GYzHltHtdOviAngvc8NeoTKZKI+5UJuayT3y2Bn6
         a6VlNa8SmXSptpw143WNd9Xh5lf/X1dAud3qFMmmtn0Dn64iodDG3yjMW2jGIbWuDJ0s
         IPkPX97Vh24wE58owGKKFIdPwdyVjzUnJTz2X4qXKtaTXmhRbKS5/NCiG3R9U2T00Yzj
         89BHl1wOWFVzcnjIUlvoggPNEDHzh0VPV1POJZTgAappqtduCCCSAGXVBCXiirPov/Zl
         0mh97PAdEZ+CuJgMJSxouZZaRnMcsUzcS76i0AMQ0PHW+BZFLAI2gkHcpFs03LQr0S6g
         dDCg==
X-Forwarded-Encrypted: i=1; AL+hErG/tMs6M6Z90FOvli7JdEyB3amsTxtvHPyD4ceCC12dDvisxObbjU+SnDOujMxsbz89RFOMldZ0FQBb1fia8+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XaePjv9oKIazP4wItoXPmAsRywo/0lKFGoipO2QDGYqPUp99e
	uNhiBCndkG7A1SEhoRW4ZJbNdEn3uBmWigyGP8qhuCNrnZKnGQTVd1W7
X-Gm-Gg: AZFdTZfaJad/Ejg/gaXFvUzZ0ZMCRjF7L+429feRZnqXcPRE0mBU7XlzYAzdImzfhuS
	4lRNCTreRwQVzoGdHl6CzcjNwGgYBhtOOWGT/GB1yW4WxE2lEoQQkG3WxIBrW6Dqj8jN05H+ZH2
	CRdmAgr0vX6tn+RTbXVPQuZJpfcec4BQJln7vm5s9wiYeh2anJfD63ZE5g5VNDd7jXlIZHeQv1A
	Jtli9lqYdj7Z09PUT8llYKaA2PGmqiTXiJ02hH+S2zu8SIE9jEQF5xvWuSaUUZbEVe8XY3ARF0l
	6Gnh8FQEF1fzo4FgG23++0mlsgUPdGi9z/09qeMvKoycwW6JoxsjOFIGOldrpQiWlM2G2yJkYpE
	1ncyp0JSwilpT3FpJgzKrvdd3VrHN2/bFB0G5VMrn9WIRhapEiBwtDnCg1b1pxpUnZfLU+/v3vZ
	WIc5hXWpJnSyMd3LowibTDS6v9ACWN/2oxvc32mwAhQgJJ21w33/IeK2Ea243cL7GYvvE2SR8qf
	HnLfZIJJ+FCzq+Sm/Y/1UjjYmwe2HXsFgsVf02JDwQezdqiO8JhA+daldbTc/XBL8dK26PEEh8Q
	vb04xO5Buzjlwd5K8/TwrWk5kc4lpYMzK1OO/LaKM8WeFlFyybS29PIySa8BzA==
X-Received: by 2002:a05:693c:62d4:b0:386:ad86:21a9 with SMTP id 5a478bee46e88-386ad862c8emr12324340eec.13.1795695298917;
        Thu, 26 Nov 2026 04:14:58 -0800 (PST)
Received: from HFGF46V04Q.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm59109818eec.16.2026.11.26.04.14.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 04:14:58 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 02/19] mm/swap: clean up hibernation error handling
Date: Thu, 26 Nov 2026 20:14:28 +0800
Message-ID: <179569520640.49764.510050912247709774@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CACePvbWzE6AvbLzNFe=J5Vid8iy6FFQh0RBgr+V_jJJ4p=OEVw@mail.gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com> <3e8d55101602d5ec982ae636eaf5eb4dcaad3ba8.1795439990.git.lianux.mm@gmail.com> <CACePvbWzE6AvbLzNFe=J5Vid8iy6FFQh0RBgr+V_jJJ4p=OEVw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chris,

Thanks for the careful review.

> Nitpick: Here "ret" only carries error code. Maybe we can call it "err".

I'd keep "ret" here since it holds the swap type on success and a
negative errno on failure.

> Nitpick: Maybe "unlock"?

Agreed. I'll rename the label to "unlock" in the next revision.

Thanks,
Lian
