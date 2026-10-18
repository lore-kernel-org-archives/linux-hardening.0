Received: from out-utut-a221.jellyfish.systems (out-utut-a221.jellyfish.systems [198.177.127.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64363B8D75
	for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358464; cv=none; b=NxBxZyERoXplm2lrkysdXErMXJW7EIwZsuSAwEPBWUQfIhsAbJcdoH70b0V9oRytAo03qa4BrGMpo2T2yyj4cu6YNnYAJNUmHljSsaq4Xkmx01zBE6OW8UcIcS6eLE2MNkqdKgW/g3thyoT1Ev9mxv0XE3+Moqk+P3Oj79X4CWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358464; c=relaxed/simple;
	bh=a22fV/RS6LK4q5vntBORpd4MDnqFImtey92ifh/lcGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e10VCbf0XyeW4YdxH6j1EyAD3/vcEeXHpBKJEDC+AO3FTClxPVJv4fAo5yVcDF2fmXleP2civVigDGnNcKl8LEBNRqQoNqDHpvx96FNvWF4BBhTg98k4N8hM4WIpkqm61gZSl5iBp7rTxKB4YWxP8Qpche/siQNHzLXTmSMcnyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca; spf=pass smtp.mailfrom=r-sc.ca; dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b=C8ecvgvh; arc=none smtp.client-ip=198.177.127.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b="C8ecvgvh"
Received: from DESKTOP-290OH2S (d207-6-150-133.bchsia.telus.net [207.6.150.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4j7BRt2ssDz8sWP;
	Sun, 18 Oct 2026 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-sc.ca;
	s=spacemail; t=1792358459;
	bh=a22fV/RS6LK4q5vntBORpd4MDnqFImtey92ifh/lcGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8ecvgvh9Sv180UXcOgFU3ffgyySZzWV6GqMVPlffIiCIMIg0BRhXcKV5pO+0In+Z
	 BaB6BjqH1NyMyMitek8PI69O1w5tWSFNekQQjYPt57Fm6Cs6P+SRRIwPB//0vZs3Io
	 KCoPaJRLVrT9+1ekU4XhzH3NGZPhBZtoL00a9YSsyZbWOx570ItYb6tWUJWtbZLlb/
	 qkdkl2DDHya1rGPeLe2MHQVGRgmeOBoESVb5Id0oUgakkx2K2KJehVrQc7DmPLENrj
	 vEQe5xIpImAePOdaeZP8ByKnQTgu5I+/2v8TA5PUp7ejnEUKo7jUt37H3wHtv7yuMi
	 flo38XXGp+cHw==
From: Ross Cawston <ross@r-sc.ca>
To: andi.shyti@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ross Cawston <ross@r-sc.ca>
Subject: Re: [PATCH 0/2] i2c: add GPIO buses sharing one SCL line
Date: Sun, 18 Oct 2026 14:20:51 -0700
Message-ID: <20261018212051.135-1-ross@r-sc.ca>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261018194315.945-1-ross@r-sc.ca>
References: <20261018194315.945-1-ross@r-sc.ca>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: ross@r-sc.ca

Hi,

Please drop this series. As the automated review points out, i2c-gpio
has handled buses that share one SCL line since commit 645c3d7d07fa
("i2c: i2c-gpio: Enhance driver for buses with shared SCL") in v7.3,
which I had missed. The MokerLink POE-10G07110GSM will use i2c-gpio
instead.

Sorry for the noise.

Ross
