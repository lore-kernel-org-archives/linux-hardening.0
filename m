Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D393F2119;
	Fri, 20 Mar 2026 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035148; cv=pass; b=dH3f7H0Ocos04zPG01Pt3+ApC6yVOeODcpdcot2mTAmk07mPzWCOmwJ1ClRtkNuE2F++HCqXvrwqeJJqgN2c1CKzn8wpWNIpkygjEwtI/Y1FHdibA0rR4AJKRBjrwIUkeMaq3VBx4lLz0CpXGeagmtKAPviSIQ8A3J0TFlLix2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035148; c=relaxed/simple;
	bh=3XStrT6FjHvFdK7FCYWQEHQTTKXpM+N1byEmwcBfcuY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JG8b1l1exp76T77B+a3zSVl2SRXHioxdrIFJ7883W24Jh20BYbbDx/h+5LHAYJH6LNZnd+IwOyLXH/fSfsb/JDOZwWciicofEqk+B9JRxgl09CtUO5CQSITGoGPJPzmly/MMrw196SaGOUGpYYV9grlkikMZ5A7Hor19HFIFmso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=aSMAwqRC; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="aSMAwqRC"
ARC-Seal: i=1; a=rsa-sha256; t=1774035118; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LeHj679HiWbCbZ50Jlj6De5XUmmbiD1gdDsrZ56+hrcZJ3At4lW9y96uXVs9BtxZWDuGHqq7WIZCcDFoJJmv2ARgsRIclVTFCK/Tq7CsItcNM59A+gPYTNCnAmMwKR7QIs/HQHN5Han0+ZPcrTsK282KPep/XdLQdL5TldkVsNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774035118; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3XStrT6FjHvFdK7FCYWQEHQTTKXpM+N1byEmwcBfcuY=; 
	b=SqcQT0MsQ66I7NnjF5V5GH0IwMvKfX7X9Qub+JBH6CZoyLXLE2DjvL2X9JnhoDbSaiskTx8Ivv2WBEdk98oJHprTHP/P67nflS6QcyVQXSBd5/ctch7w35resfOm9zVHwGZ32XP7WzV0IXXb6nAhlJ+IeLm3eS/8VurYJinhzwA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774035118;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=3XStrT6FjHvFdK7FCYWQEHQTTKXpM+N1byEmwcBfcuY=;
	b=aSMAwqRCK8XRaXaa1Ulb0DKikfqxndIwlZ3BT5aqL63H79paZaqHrXOyOzjLAPm9
	GCcII7xTXcpz7vIrMs7P9ddwLWxk8df36eQvbEx587d7O5vR7iItcmDTu4Xk3fjWlLW
	qjmgTxXB8dYdYr/k/Bp4lT66BkXBmt7FcfzaNO84=
Received: by mx.zoho.eu with SMTPS id 1774035115847579.8889874692579;
	Fri, 20 Mar 2026 20:31:55 +0100 (CET)
Date: Fri, 20 Mar 2026 19:31:54 +0000
From: Josh Law <objecting@objecting.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kees Cook <kees@kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_ACPI=3A_processor=3A_idle=3A?=
 =?US-ASCII?Q?_Replace_strlcat=28=29_with_better_alternative?=
User-Agent: Thunderbird for Android
In-Reply-To: <ab2fNTeawayVvjZv@ashevche-desk.local>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com> <202603201216.3CD33C4@keescook> <ab2fNTeawayVvjZv@ashevche-desk.local>
Message-ID: <308B1431-EEA5-4114-9587-A553CCE75A22@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



>Thank you for confirming, this is basically the message to Josh to find
>users and start converting them and kill strlcat() eventually=2E Josh, as
>you see it will be well appreciated!


Thank you! But the only reason I'm not doing it is because if I submit all=
 of the patches, let's say, 50 gets merged (including strings=2Ec) and like=
 50 don't, then 50 will have a nonexistent/slow API because they chose to n=
ot merge my patch
