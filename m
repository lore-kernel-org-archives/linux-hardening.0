Received: from mail.hotelshavens.com (mail.hotelshavens.com [217.156.64.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D971B9B29
	for <linux-hardening@vger.kernel.org>; Fri, 16 Aug 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.156.64.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814476; cv=none; b=OJOX3uLaopqG8YexSepfjnKtsbV0/0to+1xzMCzCWJP8S/QoFSBjH/tI5b/3DYgX+1Ao6QWl54kBV9SI899Q2wwg1Fxo0tPsqmazkEG6pQm9Sjkx7pd88zKLS7s8O1uUzcMxG46ngHjww6XXIqwg/baXXSyP1t18ruUXWyWfsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814476; c=relaxed/simple;
	bh=lGbWBbMJj7MjaOP5qF+bbdFlvqbbMYDgzvEYdWaBLrs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E2DiwIMiiZL1I8Y15EhSSTy8KdWaA1MWui/0VEq4jQexQTN19FSiRFYrLDfTMLtibqv5n/cEiVkjdKnxymkggxrCaU/WYZYVBb7+zeT1+3/YrcS/LMJfGQkSeCWNjKxMo8UGnpND70KhnN3Dl0cgHcsnb3hYo0CLFwyG1X8npWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com; spf=pass smtp.mailfrom=hotelshavens.com; dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b=oCJh30tj; arc=none smtp.client-ip=217.156.64.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotelshavens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b="oCJh30tj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=dkim; d=hotelshavens.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=admin@hotelshavens.com;
 bh=lGbWBbMJj7MjaOP5qF+bbdFlvqbbMYDgzvEYdWaBLrs=;
 b=oCJh30tjmHW9rHKfCpziVZ1zeojq5c96OZHlD4Ewsx14+xURU/2O8qotrOUj1IVYOi6Q43hDd9lR
   mwSBMFTSw4/Lm10kW8jlXynLT7rPr4y/kcHVELQN6GlJPBTpzwSE294e5WXTueVV9A46Iou2/ZrA
   ZIbdmUOQlfo1xVd8ix2qknyTvI56aB0sqhQlrIkX8BmPxErDGd48VBSVTRmf9f9jVUsjtB61fYtG
   d19ntEM6idy/IZbyl/zGuEyL+sqtnJNbpIp4OYbk4R8z1QH18CcqeDU8alF3lUtoD0bFuZXCPYqL
   83a+Y/s+rmG0isak97hTu58076H/k3QF2LHWni2qDNYO5Xmcgjs5dy+b7I91oyaShdDHO1msXKnO
   VmHODK2nSU0MJ2j81edVNEE8T6ImCjuGNv1FS5LNzGZ6A+QQ2HXnXSQRcUS3uLulxhfCu2FeMpE8
   XlmnGSF/GauzFOA/nKxd/w1lS8weR6yd7uGAgvKNnNzzDcwXW0GwUInk/hMgPHaWthpkKf4jPp9q
   rc2ejbn5xrS2ujahFMju0W+8O8PeovnaqNlGkETkhNqhSVeCqnQ/p1wSJzc8BxTjhuP4G8NzJvPc
   9N6cjKZxIcDjSgE19pcYet4M15ZrUW8N0Mi1sPk1llo7ES8QtCBVUVqJ+8+HC41ylXFSK4OZVIQ=
Reply-To: boris@undpkh.com
From: Boris Soroka <admin@hotelshavens.com>
To: linux-hardening@vger.kernel.org
Subject: HI DEAR !
Date: 16 Aug 2024 15:16:11 +0200
Message-ID: <20240816134828.662E8F971369B970@hotelshavens.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

Did you receive my last email message I sent to this Email=20
address: ( linux-hardening@vger.kernel.org ) concerning=20
relocating my investment to your country due to the on going war=20
in my country Russia.

Best Regards,
Mr.Boris Soroka.
