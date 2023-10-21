Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF7383
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RrxEtuH3"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB867D7F;
	Fri, 20 Oct 2023 17:53:15 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 593116607332;
	Sat, 21 Oct 2023 01:53:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1697849594;
	bh=n+cp6ATKcN+tRvhf+29E1cAWuHZDFud0FRdhecmVEyc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RrxEtuH3C4f6Vch/+SimF3XL4qNqVaVQVY++iL8EDB+zvWHlOxoIxHQvJSrFCHetc
	 lF364MHWTdFYSPAgAF2cvy9sKkdOGWTMmD1y9+4FNySwCs6AGC+Fl8WMYN/eAZcKAc
	 3UPI/eXYpAr/HR3p/+SlXTPnqclFQ7bvAz8R1/Bp+7yc0l6agFmLJrlwza7qGSgCaW
	 UBV5+o6sk5N27Dx300e8GjbQhMaXTWVxKKy5tVgbLpvqZhOd/u21AoXmO7ZNSmWH6z
	 vA9vs35uS5eiXWYrzbosDa57sBtMFD2RbAsspoOq0JSsIt2HXrjL5eTDpYjXdbaHlb
	 lk0goFfEfWMmg==
Received: by mercury (Postfix, from userid 1000)
	id 2DC55106061E; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com>
References: <20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com>
Subject: Re: [PATCH] power: supply: bq24190_charger: replace deprecated
 strncpy with strscpy
Message-Id: <169784959113.1512524.17628671686184916927.b4-ty@collabora.com>
Date: Sat, 21 Oct 2023 02:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 20 Oct 2023 18:14:47 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bdi->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq24190_charger: replace deprecated strncpy with strscpy
      commit: b0009b8bed98bd5d59449af48781703df261c247

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

