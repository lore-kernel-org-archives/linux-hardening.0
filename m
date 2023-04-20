Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B794BC77B73
	for <linux-hardening@archiver.kernel.org>; Thu, 20 Apr 2023 07:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjDTHrG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 20 Apr 2023 03:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjDTHrE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 20 Apr 2023 03:47:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63CE4221
        for <linux-hardening@vger.kernel.org>; Thu, 20 Apr 2023 00:47:02 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K6qnXJ016347;
        Thu, 20 Apr 2023 07:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=a+pGMHrSGjYYH3pDWIbrrgHydtyHeXeEsmS0wtfm4Rk=;
 b=CypS1GLVh+xNXVEsyYWkuGkax2s7tgOBAdtymNhkY1qxwt3QmDP2PwUNOUErKAWDDgK8
 3UgZsUZxyeXgU/UB+pDoFasedIrGzmBIkrNrdnWC+9hu17gOoM67CsF3WllhXb8ojjxz
 ni8YK13dmMPQgNc/NVE+D3MDBKIape5Jl+26MPfR47jMr8Nb6iuxEI7YR2MOkZpHnZoD
 R33csNdotVYuEdHr2v1PCrV25lBNxy2k0ogQ1GfRM5X3ZaE/N5em9mPP+jXfXC4jn1My
 DPi0vbMSwvalxw81bSZ05C7jsHxtpP+IGCgF4segO71WSF2snD1u1LawE0S3Z2+XVovh eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q30gx1gf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 07:46:57 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33K7Kd2I023820;
        Thu, 20 Apr 2023 07:46:57 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q30gx1geg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 07:46:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33K7hBvZ018922;
        Thu, 20 Apr 2023 07:46:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pykj6k7vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 07:46:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33K7kqwf5112500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 07:46:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9752920043;
        Thu, 20 Apr 2023 07:46:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16FB420040;
        Thu, 20 Apr 2023 07:46:52 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Apr 2023 07:46:52 +0000 (GMT)
Received: from li-c0a07e37-1ab2-11ed-80f2-9c2dcd4480e4.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3621D600E5;
        Thu, 20 Apr 2023 17:46:49 +1000 (AEST)
Message-ID: <03751d6651e65f848bfd7e574b53932a794f2f2a.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/rtas: Replace one-element arrays with flexible
 arrays
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        linux-hardening@vger.kernel.org
Date:   Thu, 20 Apr 2023 17:46:44 +1000
In-Reply-To: <87357wp1h7.fsf@linux.ibm.com>
References: <20230127085023.271674-1-ajd@linux.ibm.com>
         <87357wp1h7.fsf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 32cGLJVTY88E0VCAQ-aOeyhDAizePHFn
X-Proofpoint-GUID: RAmsFaJ5T19-b50HcB8CzCbvbahgU8-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_04,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304200061
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 2023-01-27 at 07:10 -0600, Nathan Lynch wrote:
> > > > I see at least one place that consults the size of one of these
> > > > structs,
> > > > in get_pseries_errorlog():
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Check that we un=
derstand the format */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ext_log_length =
< sizeof(struct
> > > > rtas_ext_event_log_v6)
> > > > ||
> > > > ...
> > > >=20
> > > > Don't all such sites need to be audited/adjusted for changes
> > > > like
> > > > this?

I did actually see that site, and concluded that for the purposes of
that particular check, removing a single extra byte is irrelevant
(maybe it makes the check more strictly correct, what if the vendor_log
is actually of length 0?)

Doing a binary diff, as Kees suggests, over the object files in
arch/powerpc:

- there's no difference at all caused by changing
rtas_ext_event_log_v6.vendor_log, which kind of surprises me given the
above.

- changing rtas_error_log.buffer does seem to change some code
generation in arch/powerpc/platforms/pseries/ras.o, I can't quite see
why.

Andrew

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
