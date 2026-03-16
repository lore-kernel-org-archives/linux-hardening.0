Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F673E1CE9;
	Mon, 16 Mar 2026 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686667; cv=pass; b=W090+/Dqi2g2zKr/CzKIlLH/o5ZbNfHF6ndOvbZW4RA98oUxxGa06FcKaeY7VGlgaeZJ5s7JqGsnJbYIoEbhU7rVreMe7Et2l9RUdOrPFLljTEnb7g911Qsnszxptbbd07ZVrg34TU6bGelhzmBrZk1SxyOonGEz5VJfw02CXfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686667; c=relaxed/simple;
	bh=GtFrz9KbKIKh0IkZziorROObu/Y/fy8Mvzhol31nVeA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ii7bClOxLUKGGM6MSyHS+ZdJylwEKWo2xxeJ4ya8dR/cLBbYNkHZky01vDId9RLRNXINYtFb2FPthJGnW04ilLCeTRmTkkUbh8F4YqWYGYXqNrWu0AVLOlRRMKYxWFF9wISeN2OnLGr+X89GewIclhbP6ZUYyuo2jaQsMRa9fSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=oMmG8LaK; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="oMmG8LaK"
ARC-Seal: i=1; a=rsa-sha256; t=1773686641; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Mkpu/oO/VHsCPqbOjzj9e6rvi0TRYZnQ1YNaADqgMPhokZejsZqSicZP6/fFfnHJVjBuQwskhuhN1J9eYxQE/g1uu/X516ZyQiCz1uAvlYydJAMRSodM2aTdeBVY/jXGOI3AKNPdH+YGleVSyvpptLZCLhWmmQnPAodwt6NqvNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773686641; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ek+/9mNBrNkpaZ3zR4u9yejVy5ZC/V0+MIIe2CHgd+o=; 
	b=hd+JLiAmb90wJAMeVVT94o4SXw6zMo4YwwTXZCCBlrTXR6jue5MbB7ILA7IuSDN0K1xQWK79t1EkpK4pDe9wSA54je91nX1tcOCXHzZf2IgnpQz474osqfibFrN4cZHovTiszOMu3TX/9Kh0ZotT0igdna1kXFMzoDEIexUv+uk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773686641;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=ek+/9mNBrNkpaZ3zR4u9yejVy5ZC/V0+MIIe2CHgd+o=;
	b=oMmG8LaKspBeHtZotYr+NoOI+CME9/SwzTAF1aBLeCsjOGOU0ruGNZUAbVBHngW2
	WhWdcRRCAzoZ36wApvbXAkHb86lnpg7kCww4OYnb9h0vjoXsIAKIRzI2TqSPG7HgMP9
	DsQMtC1h+Jkf3/MqYwEeM3hw7M/nNOkJ2NWl06h0=
Received: by mx.zoho.eu with SMTPS id 177368663776653.66512137874156;
	Mon, 16 Mar 2026 19:43:57 +0100 (CET)
Date: Mon, 16 Mar 2026 18:43:58 +0000
From: Josh Law <objecting@objecting.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 kees@kernel.org, linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_ACPI=3A_processor=3A_idle=3A?=
 =?US-ASCII?Q?_Replace_strlcat=28=29_with_better_alternative?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
Message-ID: <4FC4DDD1-E170-46A9-888A-41D2CD6D97F3@objecting.org>
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



On 16 March 2026 17:01:58 GMT, Andy Shevchenko <andriy=2Eshevchenko@linux=
=2Eintel=2Ecom> wrote:
>strlcpy() and strlcat() are confusing APIs and the former one already gon=
e
>from the kernel=2E In preparation to kill strlcat() replace it with the b=
etter
>alternative=2E
>
>Signed-off-by: Andy Shevchenko <andriy=2Eshevchenko@linux=2Eintel=2Ecom>
>---
> drivers/acpi/processor_idle=2Ec | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/acpi/processor_idle=2Ec b/drivers/acpi/processor_idl=
e=2Ec
>index 45b5d17443cf=2E=2E498d88f5d5c9 100644
>--- a/drivers/acpi/processor_idle=2Ec
>+++ b/drivers/acpi/processor_idle=2Ec
>@@ -1010,9 +1010,7 @@ static bool combine_lpi_states(struct acpi_lpi_stat=
e *local,
> 	result->arch_flags =3D parent->arch_flags;
> 	result->index =3D parent->index;
>=20
>-	strscpy(result->desc, local->desc, ACPI_CX_DESC_LEN);
>-	strlcat(result->desc, "+", ACPI_CX_DESC_LEN);
>-	strlcat(result->desc, parent->desc, ACPI_CX_DESC_LEN);
>+	snprintf(result->desc, ACPI_CX_DESC_LEN, "%s+%s", local->desc, parent->=
desc);
> 	return true;
> }
>=20


Is this patch in relation to my string=2Ec patch? You would have to do thi=
s for about 120~ files=2E

V/R


Josh Law
