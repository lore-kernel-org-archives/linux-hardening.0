Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0651184524
	for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674080; cv=pass; b=UbJ2HU73uTcE9T6L+0TP7cxXp6riTRbwbbX6l9s4mmUly+JyzhiQH/1nKmKMtToui8iRDjS7sb7+TtofebTm7SlwkcYr2zd83ij8i94Qs1Pgak9lsEr9hr0L5O6r6aPqL9DniYEL7CY5Uu1sMYKYZXfwH1IFE+gM7oXMhCswLFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674080; c=relaxed/simple;
	bh=ViI3ZetTHLdhKWtDS7G44X8T94FYsijf2LfLvfi0jIg=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=W/Dk4wrLsSpjMzN6ORdAOZcjPioAhSpXmR9mYiXddq8IBOdCdrXwxrx8x4Y97KL+RK2QB6ZrY5B4l98doKo8df5C5UtBsRlfCuFqDQjwcjR2bTtnm9DM0plq7f+OWOv+bjhTMv+D+9F7FUh4WAYyhUNkIHi1TAMMmgpgIBuD7Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=B/Awb7I5; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="B/Awb7I5"
ARC-Seal: i=1; a=rsa-sha256; t=1758674078; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=KkLOn4kBAP3EzEgB/QmvLDHj5H6yXwRI6oOgUOdLjYfO2h6waKCT5ouy2gD+nqIigcnizS2Adgi/znk22U3exJS/27fQjPoR6gUFY4X1KItgETS4EdMjy24DMV4WGmUspCdKUgVqoQw+ctV1/D3FgzC3x/U1uQX4El13OWq+I5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674078; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=ViI3ZetTHLdhKWtDS7G44X8T94FYsijf2LfLvfi0jIg=; 
	b=a5H7Qd9paUcRGWXsX2u9uN99PFVb/DnYGTzDWhmXW75e9gDuNlZzgv61AtjIXJwFsMiBkXyYsQjzHxaKqIKPAGPwV29mK07JPDTIHdxXJv837Ly469ORDQQkpDFxV3UP6gcjlJhQqeEykS4SMPdXLGhJ2pASKdYRwIKuPIozTYs=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a728640-98d8-11f0-8217-5254007ea3ec_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653580400.3809936463881;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=B/Awb7I5FSJGJCZADl35QB1oPPc5xrEaG4X3I2u872lGm6W+A9GFRVaPzS57RF9A0SN9dYziIgqUd/UktdZ6bvHC8xDHZDwRoKRw5OPkEBcrKpPJGzLurZBGUUOMraWBfKY3Xz7zlHI9dcjq0k/OV+r/HTIcdzn4CJh9BAole0E=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=ViI3ZetTHLdhKWtDS7G44X8T94FYsijf2LfLvfi0jIg=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-hardening@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-8217-5254007ea3ec.19978ffc4a4@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-8217-5254007ea3ec.19978ffc4a4
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a728640-98d8-11f0-8217-5254007ea3ec.19978ffc4a4
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-8217-5254007ea3ec.19978ffc4a4
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-8217-5254007ea3ec.19978ffc4a4
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-8217-5254007ea3ec.19978ffc4a4@zeptomail.com>
X-ZohoMailClient: External

To: linux-hardening@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
