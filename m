Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26614641
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MYPegSmh"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE0D7B;
	Fri, 20 Oct 2023 17:53:15 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FD6F660734B;
	Sat, 21 Oct 2023 01:53:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1697849594;
	bh=GXgeyflELdkwQaARUoLno8eG7vio7GHwgM7DNn3lj9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MYPegSmhMFycgB3lMm27WtFNF9umqRyZHDmSmAp3df58pWUOer3mhVluJDT0LFTrb
	 fefya9/fcEQqXHzY7FfyC9W2xcl0JCVdaDivV74fsVDJjyYv3S+SA0jHyyqNfJEEAt
	 jWOoT6Z/e4llA1CmbG1skCUv4+jJK7uq5aAzbYACCFsA1+IqL6PeE8wiLxKpjPuCi8
	 H0+mpM3EaBnm2pTteD9exN4OYUAewMzjV+EqAWUIyCpC/cwhcsaqWn0FqxaYZFNfCS
	 OPgHK3kjzEOR/m3EHf/gnd7cmR8opdfi6sA8IY5j+A9gK4J6D6t2vjiYzx2Xai6odN
	 IP/6yGdDJb1+Q==
Received: by mercury (Postfix, from userid 1000)
	id 35B201066141; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq25980_charger-c-v1-1-7b93be54537b@google.com>
References: <20231020-strncpy-drivers-power-supply-bq25980_charger-c-v1-1-7b93be54537b@google.com>
Subject: Re: [PATCH] power: supply: bq25980: replace deprecated strncpy
 with strscpy
Message-Id: <169784959121.1512524.5902805888550029503.b4-ty@collabora.com>
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


On Fri, 20 Oct 2023 19:11:07 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bq->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq25980: replace deprecated strncpy with strscpy
      commit: afb0379b0f6657b9f626d23c3bb00b4e8823bd2d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

