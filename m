Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA4FC25B0E
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Aug 2022 03:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiHQDKI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 Aug 2022 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiHQDKG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 Aug 2022 23:10:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1BF6110E
        for <linux-hardening@vger.kernel.org>; Tue, 16 Aug 2022 20:10:05 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H2pdei023573;
        Wed, 17 Aug 2022 03:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IWt2lZMWA8FzssMXZ5lZ06kyNaT+bh+/QstI0WDn9Lw=;
 b=OVLOwXJSBrjlhohHAo51tr6MHM8t7/U1qHhCJ6CFrcL2olUXuu+iee9nZiuR5DR+gEUm
 lMlZvovpYp+WQntoTYiLcaGWQbYBmf7Qc5U++htSZA2pT1Cx+dISm+BAXVmC9kPcdkBi
 PEnNxRF614CLNrdXSl0JPifnSQaNDTqwPJAfUjbD6Si6hl0Uh5crioDo0o9U0PnPkfVb
 Eux2KGlmdtegEBWbLqcGJH4pEp/ide0mLzJZXYspMX0x0slQafODo2jW5iWMYZCGyd21
 b3LQM3DOPXr0YPxURoWiw2+Vgy0j12A13dFmJ2pQvju18SJCuYiRrGM/ih97ipe6FdbT Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0qwvgatb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 03:09:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27H2x5tV007112;
        Wed, 17 Aug 2022 03:09:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0qwvgat0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 03:09:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27H386lq007729;
        Wed, 17 Aug 2022 03:09:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3hx3k9bvjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 03:09:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27H3A9rB25690486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 03:10:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2EC642047;
        Wed, 17 Aug 2022 03:09:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C7FE42045;
        Wed, 17 Aug 2022 03:09:50 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Aug 2022 03:09:50 +0000 (GMT)
Received: from [9.43.185.126] (unknown [9.43.185.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 39A7A600A8;
        Wed, 17 Aug 2022 13:09:40 +1000 (AEST)
Message-ID: <2db81b1ab2b1b1fc4992479582cbb47cec7c839d.camel@linux.ibm.com>
Subject: Re: [PATCH] gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin
 disabled for a file
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Erhard Furtner <erhard_f@mailbox.org>,
        Emese Revfy <re.emese@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org
Date:   Wed, 17 Aug 2022 13:09:33 +1000
In-Reply-To: <YvuKKngQ/l24+7rH@yury-laptop>
References: <20220816051720.44108-1-ajd@linux.ibm.com>
         <YvuKKngQ/l24+7rH@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cuoSlccUZOC3cfGCX7joxwGfIGcz14-T
X-Proofpoint-ORIG-GUID: DPUwqFi3MbnInnFko4IpkZh3YzVtifMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0
 phishscore=0 mlxlogscore=829 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170011
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 2022-08-16 at 05:14 -0700, Yury Norov wrote:
> On Tue, Aug 16, 2022 at 03:17:20PM +1000, Andrew Donnellan wrote:
> > Commit 36d4b36b6959 ("lib/nodemask: inline next_node_in() and
> > node_random()") refactored some code by moving node_random() from
> > lib/nodemask.c to include/linux/nodemask.h, thus requiring
> > nodemask.h to
> > include random.h, which conditionally defines add_latent_entropy()
> > depending on whether the macro LATENT_ENTROPY_PLUGIN is defined.
> > 
> > This broke the build on powerpc, where nodemask.h is indirectly
> > included
> > in arch/powerpc/kernel/prom_init.c, part of the early boot
> > machinery that
> > is excluded from the latent entropy plugin using
> > DISABLE_LATENT_ENTROPY_PLUGIN. It turns out that while we add a gcc
> > flag
> > to disable the actual plugin, we don't undefine
> > LATENT_ENTROPY_PLUGIN.
> > 
> > This leads to the following:
> > 
> >     CC      arch/powerpc/kernel/prom_init.o
> >   In file included from ./include/linux/nodemask.h:97,
> >                    from ./include/linux/mmzone.h:17,
> >                    from ./include/linux/gfp.h:7,
> >                    from ./include/linux/xarray.h:15,
> 
> As a side note, xarray can go with gfp_types.h instead of gfp.h

Indeed, I just saw your patch to fix this.

> 
> > Fixes: 36d4b36b6959 ("lib/nodemask: inline next_node_in() and
> > node_random()")
> 
> I think it rather fixes 38addce8b600ca33 ("gcc-plugins: Add
> latent_entropy plugin").

You're right, I was in a rush and should have tagged that
appropriately.

> 
> For the rest,
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Thanks!


-- 
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

