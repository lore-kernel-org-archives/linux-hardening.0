Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315161FCA
	for <linux-hardening@vger.kernel.org>; Mon, 17 Jun 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620649; cv=none; b=hjiRzLvu1M6v9HezLO6Sa+MuIZpA0PegKQ8ZE85+nh5dMnY8QVdpbY364hghuUolMGPe4vl6/Ud4xNIZTB92OFKTZgI4tn5Ffa/pxrTLxo5AFn1fQCpb2F0tVKl6boc5MT4sPl4Ye/eqIbP9nQVBZIw6IyBudOk76iQ9uVofd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620649; c=relaxed/simple;
	bh=4uefxUa3a9LP+MCLZnxr29CFPXRkG1whhVbsK8cUh3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWhyI6gX8ltgYy+L6WKBO8eyMxAXqyJEVkQAeg9fNFzD95XKW0AspSJvKihXAIWqu0IaueFHqdmx+Hz6Ox+5fVqI8XygHlEAGG3GbzdVF/ny0ShPGG+wKTrGI5ttzxwlp9QrkI9ZDxyOl4vWeCnRW6eOuuF2grv880BVAdM159A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ScnLjkns; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ScnLjkns"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HASfpu032530;
	Mon, 17 Jun 2024 10:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=MWMaoAiqmft/zbpMeNg9ld9SQyl
	youiRTRBzEcBaGUw=; b=ScnLjknsQUHJDsifjY6o/iTpCSbY8qY7WYDQFr4V+/V
	XUFuI70ebPuVivWFTTKxDQTDJ6R8yGX3Ups86SMC3SWPaptWBGgMnDc7KJv/Z/F7
	BzIFkVhc3htPz+xau225j9t2Fg9p4LUP+ZTkSsokuQMC4I4bUFGlRkdcl4gEzHRp
	nH0j8o7n5uQPH+fqm7f6X26zYZ/nlZFr31i2Gs/kcvOxPN7E6OzeNkc0XiAPAGwu
	FEYCmHvxIY3YbkyYMCZC0o7XNxADtzyqe9/I+26D0nBC7LV9BOvnvB2FdUnRs0p0
	o9KCSD+n5J6sKyX1/AB7oNG6Gxr2AIkh8jmeFFA38cw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytkdy80j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 10:37:14 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HAZD3D011113;
	Mon, 17 Jun 2024 10:37:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytkdy80j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 10:37:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45H8p4ik013397;
	Mon, 17 Jun 2024 10:37:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr038psy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 10:37:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45HAb7ZH22085972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 10:37:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78A902004B;
	Mon, 17 Jun 2024 10:37:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EA9320040;
	Mon, 17 Jun 2024 10:37:05 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 17 Jun 2024 10:37:05 +0000 (GMT)
Date: Mon, 17 Jun 2024 16:07:04 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Anjali K <anjalik@linux.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        naveen@kernel.org, christophe.leroy@csgroup.eu, kees@kernel.org,
        gustavoars@kernel.org, linux-hardening@vger.kernel.org,
        vishalc@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries: Whitelist dtl slub object for copying
 to userspace
Message-ID: <20240617103704.GA767455@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20240614173844.746818-1-anjalik@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240614173844.746818-1-anjalik@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PQ3ZEPsMTNkTddVrX4AEIY9QeeyvaTbg
X-Proofpoint-GUID: -0XmxuUa3SKWm0q_aWvTa5xWDBbMr97v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=941
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170080

> Commit 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> requires that only whitelisted areas in slab/slub objects can be copied to
> userspace when usercopy hardening is enabled using CONFIG_HARDENED_USERCOPY.
> Dtl contains hypervisor dispatch events which are expected to be read by
> privileged users. Hence mark this safe for user access.
> Specify useroffset=0 and usersize=DISPATCH_LOG_BYTES to whitelist the
> entire object.
> 
> Co-developed-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Signed-off-by: Anjali K <anjalik@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
