Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2A201006
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442751; cv=none; b=dlPKVr/dtUfxIlq7lz2i4V3U1n7w/5VoG626HD21xeCJMDrq2sjA+6BV4SQM+xmQDBpyTkLnMDecBKeUZi1jn09covtbfbiIR3O4KIpqb65bIy/BIj/80mUyBr4y3OjBnTZMBr92E/gfypQmbli6JvzO6iD5wQsz0BYKi6mq+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442751; c=relaxed/simple;
	bh=RSb6AWuuOTKDXx/iwJOiFqPAdBRjDemlLkiLcOpxrPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqFE/mLbQC+Khb27X8wLmalB8/1k/8B0mz+DKJhqAkDJ2pp6f3zj/Nt5WKqSfgaCYKrakOAB77WP+zJXnCm0qmarx07n6+/w+8wD/obOGcTJvgc/D8wSU93HDcaKEQ/LK9U4vamvgk8ogXf7wqLngZHNybLSGfs+KH3UUg8fvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+HX2z11; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+HX2z11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739442746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft4Xrl2F2mgPSEHxN3B5fwyLk6cWe4p7NtJxQ7scBGU=;
	b=c+HX2z11x9xj7CYcbhNfCg3vNanl9VP30+nVVfz7RmQU9A6J+OPWNV+djrxGUm/Mq+x6Yv
	rxAmaz7RotKy3AK9f6tT0GC5TTU+upfovhG0bKnPd9iw5xDn6epFk+lej88pl+N4DXUpf+
	CwVztTpzvcXc2Uh6lPxvuqAFiKRU78k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-H3HM_lbvP-uFPwT5lQ9d3g-1; Thu, 13 Feb 2025 05:32:25 -0500
X-MC-Unique: H3HM_lbvP-uFPwT5lQ9d3g-1
X-Mimecast-MFC-AGG-ID: H3HM_lbvP-uFPwT5lQ9d3g
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5450bc1c4e6so362428e87.2
        for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 02:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739442744; x=1740047544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft4Xrl2F2mgPSEHxN3B5fwyLk6cWe4p7NtJxQ7scBGU=;
        b=ZlsLmqe8zSdqa//bMEZ9whEiKufVt6QcbnVmW2g6tgmJboFZO8EwThEF3eRUCcfyK1
         hr8lSJ8jqmafPGXXiwsMgJ05gIijK8G7i0TJD0G/+4bjDkzulokyDqRS0PiRQa5oe+LP
         jFVRqSBM8iSln0E8Kt1cg1Bnyi3lWM7hKVn9sT/3HDjBwUf7UXbcU5xr7xJB68Pq7WPn
         GVwFwqxijtul+vVtCezQ1grvx49bVvt5KjXcSiISHGTNtyAfyS4gJMr5YcAXPh/3/YDQ
         sPr1dzZgo/F3tWFNs4xCLxvlC/DqZglZ9JwvCgTyO1UbEMP5ZoQb77PoblXdPVY5e8Ah
         qaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmTrm37sf8BfTLymUlEw8M/ghKi71BM9enj0ua5bGKV7p6fQQ+U5BHeJsr8ck1uNGf/NMpkLPmxe88+ZsrSYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPykpvj94cfuTtQGp2vCfPS6KSx+VXgFDL0QXaP8WgWCMDwmU
	OfTBwie/BSLPh914yG2f0UKpIVDLVeA7JjBKIL1hJP8S5YsS0BxDbf24ii1SVI+dhAbfEWjtQJR
	h56a8cpCjIuT5gs8CLVOKWSiIoS9/k+vgc58kcecR9JZOm99WXQc8hQLfWUqBc8fzHQ==
X-Gm-Gg: ASbGnctLtE8c4qrF0CrYgPzl/Xu68wPUu0JzFQ0GaJxYg6MlozdQHVz3oA3NY7c/gl0
	lvNP2is1Yi34lLRFHEfSbs14FmDtj0n+W+rni5G2xLgueciUDxEJKWL+P1nJmHhVlsjpb0nd2qU
	9hgaO+R0GQaMggd96GxcrCPsiXWHZBDhxxS4v3rDWK84FY5j8wxlV/CBO1TATew9f5WkUL816yA
	G56WnWeGts1ciRCkZyII59OtfECaH8ehY8vPJzSFJoiMNwNGeJ4SLoF+yyymZDczOm0NrLsgnP4
	OcUCpX8oLBlON6SpNMHWAi8EMXPPtYxF9+Y=
X-Received: by 2002:a05:6512:1288:b0:542:8cf5:a3a3 with SMTP id 2adb3069b0e04-545180ea9bdmr2313815e87.5.1739442743796;
        Thu, 13 Feb 2025 02:32:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOjVjfgWpSxlDgp1d5SSfQqcJAl+Kj/IMfKejulsNDq4Ht7M1ACB2G+v8WrXUKd+ndKzht2A==
X-Received: by 2002:a05:6512:1288:b0:542:8cf5:a3a3 with SMTP id 2adb3069b0e04-545180ea9bdmr2313793e87.5.1739442743361;
        Thu, 13 Feb 2025 02:32:23 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f083443sm131485e87.33.2025.02.13.02.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:32:22 -0800 (PST)
Message-ID: <875da042-ef68-4036-beab-9beff1e21ab7@redhat.com>
Date: Thu, 13 Feb 2025 11:32:19 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] octeontx2-af: Fix uninitialized scalar variable
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: hariprasad <hkelam@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250210-otx2_common-v1-1-954570a3666d@ethancedwards.com>
 <Z6rk3Z6TuFSJgSaV@mev-dev.igk.intel.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z6rk3Z6TuFSJgSaV@mev-dev.igk.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kJYbG-vA_2qb1Zxa-kngXP5iH5kggVI3gPDICCW9CGQ_1739442744
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 6:50 AM, Michal Swiatkowski wrote:
> On Mon, Feb 10, 2025 at 09:01:52PM -0500, Ethan Carter Edwards wrote:
>> The variable *max_mtu* is uninitialized in the function
>> otx2_get_max_mtu. It is only assigned in the if-statement, leaving the
>> possibility of returning an uninitialized value.
> 
> In which case? If rc == 0 at the end of the function max_mtu is set to
> custom value from HW. If rc != it will reach the if after goto label and
> set max_mtu to default.
> 
> In my opinion this change is good. It is easier to see that the variable
> is alwyas correct initialized, but I don't think it is a fix for real
> issue.

Yep, this is not a fix, the 'Fixes' tag should be dropped. Also I think
the external tool related tag should not be included.

IMHO have the `max_mtu = 1500` initialization nearby the related warning
is preferable.

Since this is a refactor, I would instead rewrite the relevant function
to be more readable and hopefully please the checker, something alike
the following (completely untested):

---
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 2b49bfec7869..7f6c8945e1ef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1915,42 +1915,37 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
 	mutex_lock(&pfvf->mbox.lock);

 	req = otx2_mbox_alloc_msg_nix_get_hw_info(&pfvf->mbox);
-	if (!req) {
-		rc =  -ENOMEM;
-		goto out;
-	}
+	if (!req)
+		goto fail;

 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
-	if (!rc) {
-		rsp = (struct nix_hw_info *)
-		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
-		if (IS_ERR(rsp)) {
-			rc = PTR_ERR(rsp);
-			goto out;
-		}
+	if (rc)
+		goto fail;
+	rsp = (struct nix_hw_info *)
+	       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp))
+		goto fail;

-		/* HW counts VLAN insertion bytes (8 for double tag)
-		 * irrespective of whether SQE is requesting to insert VLAN
-		 * in the packet or not. Hence these 8 bytes have to be
-		 * discounted from max packet size otherwise HW will throw
-		 * SMQ errors
-		 */
-		max_mtu = rsp->max_mtu - 8 - OTX2_ETH_HLEN;
+	/* HW counts VLAN insertion bytes (8 for double tag)
+	 * irrespective of whether SQE is requesting to insert VLAN
+	 * in the packet or not. Hence these 8 bytes have to be
+	 * discounted from max packet size otherwise HW will throw
+	 * SMQ errors
+	 */
+	max_mtu = rsp->max_mtu - 8 - OTX2_ETH_HLEN;

-		/* Also save DWRR MTU, needed for DWRR weight calculation */
-		pfvf->hw.dwrr_mtu = get_dwrr_mtu(pfvf, rsp);
-		if (!pfvf->hw.dwrr_mtu)
-			pfvf->hw.dwrr_mtu = 1;
-	}
+	/* Also save DWRR MTU, needed for DWRR weight calculation */
+	pfvf->hw.dwrr_mtu = get_dwrr_mtu(pfvf, rsp);
+	if (!pfvf->hw.dwrr_mtu)
+		pfvf->hw.dwrr_mtu = 1;
+	mutex_unlock(&pfvf->mbox.lock);
+	return max_mtu;

-out:
+fail:
 	mutex_unlock(&pfvf->mbox.lock);
-	if (rc) {
-		dev_warn(pfvf->dev,
+	dev_warn(pfvf->dev,
 			 "Failed to get MTU from hardware setting default value(1500)\n");
-		max_mtu = 1500;
-	}
-	return max_mtu;
+	return 1500;
 }
 EXPORT_SYMBOL(otx2_get_max_mtu);


