Received: from mail-oa2-f21.google.com (mail-oa2-f21.google.com [74.125.231.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB6414A08
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603065; cv=none; b=nMrinNVI9Amm2KmSy3v7YaaV+gcBH1rB0OAQq/0vsDxwPmnlv33A+EjzR7rFJ9xL1DuCCnZgX4kyClY9oC0yJJHOSnIJBF2XBtauKLgio+YkHOTCFQoxdUuaw+YoEgwQVX/TJCpv5SHViGdcqHYOX9n4CBhr9mJQhptJE/eg/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603065; c=relaxed/simple;
	bh=GovrrZN3cHyF7Si62BejyKGqmJUiVqEeTzDNhyu+l7I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=eu5flDrSwrKdKW1N7RE8MSA56wYF0WJa+xPlIXYyuKpBVWNqi6W8rMOYtxNpCg4dQaTGORDHwakmcMk2ag3rqNsnOyESXx6HPC5dargLReZS50O0pfCudMc83pGUqL/iq6FlaBIdwpXsoJMrQGZfRgcNnTxswC6gP31TXB3pSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1mrqWpK; arc=none smtp.client-ip=74.125.231.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1mrqWpK"
Received: by mail-oa2-f21.google.com with SMTP id 586e51a60fabf-466ccbd4773so947838fac.2
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790603062; x=1791207862; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OqSWB16/v2nKqaGPKDp/hMATqYQmRiJplxi26oO8Rsc=;
        b=I1mrqWpKIyYVHM2mopl6yYRHDwrulVZbbF6uu3h5rKDvIeTItVCmKw5AUiOksIuCfQ
         eFEUqz9ZPvzm1t6cQ/NINZilvbKt8uqX5cHtlvg3qznVv0vk0pXDf7/rxVUap6WzWVx9
         5w1nMpOt2dG8Ms/7S8ssDdYopIlSJRCDyb7XTLK30Fvp+212CsfCzaDDfqKqI5iGR1sz
         HFEf0np+OBbXMTBffRsQoGMqYLs9q7HYQkHQWGT1mwrv2MVkVG7TBtSSkFUzk/6QkMIB
         IguvbvIKZishggAu3DEMhsJ6IZlDBCfCBg4PIqzpbXLYEiXEdsnnW70ZQUy54y+A6/Jh
         9pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603062; x=1791207862;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OqSWB16/v2nKqaGPKDp/hMATqYQmRiJplxi26oO8Rsc=;
        b=oVWt9WRj9tI0uP1tv6XO5FwWMwVA2mnvx1RdLbvYupnyYAxUgKIMTMYyk4EM5Hcwmf
         q29HtJ9NJv2fGWIhQk4c6zOeDW771+ioB8QtbGULN8yMFKHVnaMDsIgHGpcIrE57CAzV
         KJR4d/IyFV0CXd6QztEnk5jWo+uD9FBfS0yrZdCUTxp4L95gvJpXnA1t3LxY9H6DjNkV
         8/KFIrBD/9zXHmj5W/ZCZcnlkHKo9+d/lR3IiC0yf7fulOdQi6RUgz7+MbbSVYZ7rIAF
         44MIRqqGZuXsxfW/vqhDth1rGKAHp3dmozIeNbHqWcsYdgA14AamNCw7EIq1/AuocLe/
         aUUA==
X-Forwarded-Encrypted: i=1; AKwUvBxyVOET2yZ6x10lsSdqmx5O8yE50SEomOAdyt4Rh703WoZPiIt0Xvqqp84M2I0qVENEy378fqVTHShJfJAe1yk=@vger.kernel.org
X-Gm-Message-State: AFuF++mVoxr48Zq1QfyNY25AptEfHjvGZpu3ZG6OkvUJprQ94KQlwl5J
	YqROQyBQ++b5d9Gd3HXxlx7vgUy0ew2ayo8XxTOM2bGGaM0I5dHM5IOU
X-Gm-Gg: AYBFou0KMP4ga2FKsIEOehaYEgPFkx3F3tDTj43XTgZJXbP/HZikgxRJ4mK9h8Evev+
	s0HR/e6euHlhS3beQylLyrWN8jHaO9pwf+j35t1djLgTp2pW2KjyehbGAY20VuTAkvRx/y2VcEB
	nsyU5iIhRQtApeefWaXmQ2u9QwFx+8qEpttoWCbixNPly9xObC+7IN0mxp0EjGc/hcUsqSyT6dc
	/Q3uoiX6E73CmB8o/4pjUfupP5MdGJvIVoi9Hq2Ae+o4n1zrvNLewH8JNcYN3w1B676vWsS2lGh
	7hwzGCIjVM54LASYsUsN6iEcwwbxG12ueZPIKAb8M4k7PM5SPHKQYb7rsyhBbETkac4CdAJSKPM
	elo/AlPG+l6FHeDsW7RVoKRlKd9/nQURn0Lu1FHIX6jXSkENmYCi2GhypbQU1n363qrwe+h5G39
	eIioRMPor2BcqkL9UMX8cdliv+tDQluJT1GmbOLfeCPysouRGPZlBptBRgPCGjwmJ7BWpjZoMXB
	CtRx6OLURngfTG7KJwsuwZaGRyU8HEckPFOeZHl4iO9wJSGgoF4Hg==
X-Received: by 2002:a05:6871:eb03:b0:48f:e0f6:c46a with SMTP id 586e51a60fabf-49358a317cfmr9008681fac.56.1790603062123;
        Mon, 28 Sep 2026 06:44:22 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493356565b6sm10053356fac.9.2026.09.28.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:44:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
In-Reply-To: <20260928122837.8782-3-amachhiw@linux.ibm.com>
Date: Mon, 28 Sep 2026 19:12:53 +0530
Message-ID: <tsn9jxuq.ritesh.list@gmail.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com> <20260928122837.8782-3-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> preemption disabled, because it can return with HPTE_V_HVLOCK still held
> until the caller later unlocks the HPTE.  Existing virtual-mode callers
> in book3s_64_mmu_hv.c already follow that rule.
>

That make sense. LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

