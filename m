Received: from ene-kolla.pt (mail.ene-kolla.pt [89.149.207.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4C4EB48
	for <linux-hardening@vger.kernel.org>; Fri, 24 Jan 2025 00:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.149.207.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737677755; cv=none; b=N2BPocDkHbKgzpThHaddFgLpDiijMbi83rfVy0eol1qY189DMBKdp5YzoDnH8YfE0y+VSvFslR6ijfxkd90lL6YtzawksluMB9DU6s20z3UIh0NvP0bnXR+ochuctjN5WkQlnPlheJXYHLshPqs4si8SyTJuhk3RWtvY/d36SpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737677755; c=relaxed/simple;
	bh=6Cz1RoC77WgRsOJMWY05qhxtkmo/QejZ9PVT55bwtTs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EnFmoMknUUh9SLkI5AQwAk4n02G6nt+6QLN3xqj32/74VZbm3xq3YtmqVIhBRY8gkOc+NP87qLZ/bRow4iHIpN1PtM5hnOd8nVr3L28A2aKkybjxrjpvDaGQwGyZSR7l57wwxuZICYfNo//7CJSGzRsqaa0pKey1IaPPbiTOubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ene-kolla.pt; spf=pass smtp.mailfrom=ene-kolla.pt; dkim=pass (2048-bit key) header.d=ene-kolla.pt header.i=@ene-kolla.pt header.b=KT0hLjbc; arc=none smtp.client-ip=89.149.207.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ene-kolla.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ene-kolla.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ene-kolla.pt header.i=@ene-kolla.pt header.b="KT0hLjbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ene-kolla.pt;
	s=202211; t=1737677751;
	bh=6Cz1RoC77WgRsOJMWY05qhxtkmo/QejZ9PVT55bwtTs=;
	h=Reply-To:From:To:Subject:Date:From;
	b=KT0hLjbcbskd9KXlYgIiK1H7+d7aybTmPWrApiQhsL09U4deGGwP22xT0pnFV3jBk
	 ZJS/r1QJbLr91rjOzqnvdaaU6HcuPkzDme5v45s9wlG5iQ+oRHXPtKQgs2ybRlbo8S
	 WY/1bJ/I0Ha8k44MadYz7S00IApe13hCcelq2wiaNVIrD6dsi1Tf4GAt9wMJkwdoLA
	 +ysN2Yo9OI21trO0Ieq3ffT7ErG3DnMOn85c3roh8M/oiX6yS5oxj8Nfvh14AndqFG
	 qAFXdQmhctVDNYP3pB7qsNhtg2Q4f9ADNPHabhIyHQq6fB5rMJ5MnYB/sMCOKDYhx1
	 co23kNBCq0eZg==
Received: from [103.202.55.136] (unknown [103.202.55.136])
	by mail.ene-kolla.pt (Postfix) with ESMTPSA id 8BA55F8EC2
	for <linux-hardening@vger.kernel.org>; Fri, 24 Jan 2025 00:15:51 +0000 (UTC)
Reply-To: wioleta.raimer@invpolamd.com
From: manuel.rodrigues@ene-kolla.pt
To: linux-hardening@vger.kernel.org
Subject: urgent request for a quote
Date: 24 Jan 2025 01:15:51 +0100
Message-ID: <20250124011551.EB8911BC7A6A56D2@ene-kolla.pt>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,
My name is wioleta. we would like to know if you export to=20
Poland, as We have active
projects that require most products as seen on your website. If
yes, please kindly keep us informed upon your feedback so we can
send our preferred listing for quote. For further information or
have any questions, please do not hesitate to write us.
=20
Sten Arnlund
Purchase Manager
wioleta.raimer@invpolamd.com
a: Vedwalterdige by 2, Holmerskulle, 432 68 Poland.
