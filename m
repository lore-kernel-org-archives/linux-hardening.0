Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E1BC4320A
	for <linux-hardening@archiver.kernel.org>; Wed,  1 Sep 2021 17:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6B561059
	for <linux-hardening@archiver.kernel.org>; Wed,  1 Sep 2021 17:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhIARRi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:17:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:61163 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344703AbhIARRh (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 1 Sep 2021 13:17:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="282527765"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="282527765"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 10:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="688453764"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2021 10:16:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 10:16:39 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 10:16:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 1 Sep 2021 10:16:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 10:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7UIZtDC4mgeDKGseIBNVKuYQRs+lvyljrYXjVY8L9jjmlkALACI3rirsQeFev7dKTvoPl2HMiW+FcwaFrG65rU99WK2ZjdX0reXK+zHml7AirpDpYZyqT2FYxy6V7NUzrb6rJnNSvaCBAsy4xBmXHgRxs4sdLU025QMtIwHiPgb2gxJarHLIKm4iQFn0kgkqEzeFBrVbt47NZKIJQ1tG/fO/ZiJsYnxMtU5p5+EsZ/5xChKtE9QgclZN2rZCkNbOHdpg0n+IeF+oX2X0ouZ9ChBds8AQrfzHa8fDXU3c6TVZ/l/WjhjsLpl9xGGKBGWDv9Du37h/5CbN31Tu1N/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9xTGzOs+MM9Yw2II9+KHW+t/A3meuryr7apMG2yoPY=;
 b=RuldtcM3nrNtKhLbtDLz7Wl9LxIt/KmxBvAqmnJyR+WMO561nIDJm67+gaomYe9WdMYKN5CQeR9iomrYto8lR+JQcOqkhLL4/v47nPM4wPSK87EwzxdIfS/AvKEaj/99JT83MMVVFqzSDeIc5nHJwTh8gw1IqDyHmFuWb0ZlCxur4BY/oYf8GkgifDiaHLHv/gqsj7BfE+eGgWs7RjjFmI46Rgg5YQCGaQrYXxrfjItV3jQI/WYIcKMjRrwGGpT9zX38LePOwEq63HCOZVI3eqGFDgTAY0A6n6bAfmloI6jnTF0EWavHOHLKE4GpIjlLSxpjH9JFh0DZk4XvokiRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9xTGzOs+MM9Yw2II9+KHW+t/A3meuryr7apMG2yoPY=;
 b=c1wTooU89VQWKBoPwJ7GAFSzPx+s8+zr5j8hqPaUJxaeoDFHW4+4WTz70JAZoGBmtdhZtJnHlao/lZANoOcdzz0hQGqQOMXRwqTmqd44bz3tSZCKYtNiKyWwJsbzBGZUheD7MB7XXVcgx99BS8jFBm/bfRjP1rjc84hzBKVMS9Y=
Received: from SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6)
 by BYAPR11MB3767.namprd11.prod.outlook.com (2603:10b6:a03:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 17:16:34 +0000
Received: from SJ0PR11MB5069.namprd11.prod.outlook.com
 ([fe80::e985:b20:37df:f9f0]) by SJ0PR11MB5069.namprd11.prod.outlook.com
 ([fe80::e985:b20:37df:f9f0%6]) with mapi id 15.20.4415.029; Wed, 1 Sep 2021
 17:16:34 +0000
From:   "Accardi, Kristen C" <kristen.c.accardi@intel.com>
To:     "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Kubiak, Michal" <michal.kubiak@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>
Subject: RE: [PATCH v6 kspp-next 00/22] Function Granular KASLR
Thread-Topic: [PATCH v6 kspp-next 00/22] Function Granular KASLR
Thread-Index: AQHXnnZ51i/Rn0rV4UunH/9tG6AK0quPZzvw
Date:   Wed, 1 Sep 2021 17:16:34 +0000
Message-ID: <SJ0PR11MB5069BEA47733FC88637B7809AFCD9@SJ0PR11MB5069.namprd11.prod.outlook.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 152d92d6-9a14-4912-1653-08d96d6c3fee
x-ms-traffictypediagnostic: BYAPR11MB3767:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB376767356C93103BFF2CB7B5AFCD9@BYAPR11MB3767.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U57wZCb15dwP3MsxtdZO5oeQS2SyCvRi5/oeIFwsfazetWfW1E1M/l1EqFRfxvRDM4Xx/0fRfReR02a1yMkSmwbLtPLms1jpNOasd0XXExnxzqh3V71tDWIDKKJI637q3UbeeWbnhyHgxMTCjaiQgFNBKkfUNe+P99F9xMId8QbD8eBcDoTV+L2hpN0CHjMG7iYkTXxGgWIufBBqtwDeXX5dfaaI6ssIjICfSuYTHM5Vrk+1b+ryziCcOdHi3Kcp3NUSnXfuLgCdKqOVjgLKgtT78as/qrn+nU2uamF2/8gPa9LKaVSim69obIN4fT8v3BfcqWQK8so1Cv7C+R9M+v9lESTVpFNXhx850u+gid+XeE1p59UZwqNJfG7lEbL9PtEVbkryrEH5erLjkokfqf1PJBgxlRPbPQz9tL5HATYOwhLgNgCj5o0Ew2oF9LRbJaRjQyGCnq69prLYkPojzLDPX/CKqzsU7bivLJ3RItwvKco6Ueo/DUuCERh3nmLpvMhEGNYtwLUG7poH5niRJrPeHmawe1B3u9Wk/VLKSvmaKn+lU4d7b/JBniIf5HIcrls1h1RNzKqxaWpoBi584f4T0MOJap+rsyIn6QczaXPgdwtMf8tmlIu6fIaqqapPA7BXDkrmKcdDcOvvsmY98XoX+5F0aJLjRLwQuoqeyxt4q2n1SRwip8jhQAyv1AYH8dkIFXTSj98trQzQ7zKCKjaT48wCNNRP65xJYFtXGYZrZS6YcDBeSUxOqdqZ8lbm58Pusiwzwnt7L+JO/zq7Ovf+06BT4LqCShx+HNEFcVWZRLYV12DHykc7WvG1Birs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5069.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(186003)(38100700002)(6506007)(71200400001)(7696005)(122000001)(53546011)(26005)(8936002)(30864003)(2906002)(478600001)(52536014)(55016002)(9686003)(316002)(76116006)(83380400001)(110136005)(54906003)(4326008)(66446008)(966005)(5660300002)(66946007)(66476007)(66556008)(38070700005)(64756008)(33656002)(86362001)(66574015)(8676002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M/vDHKFkf0niRJ2YCNpSsh1mcSLu642t4QLoUmFHfvrODvklKbRNWhQiAhGZ?=
 =?us-ascii?Q?204B71Ue5TlrW/PK9vPqAomHCyLAvgNqTMSn6jxHvkRH1fayXMTTHFfYrrJW?=
 =?us-ascii?Q?GOHL3eHybRJ43OHmcf1nSpeNTJ6w9V0EwGxC6we5P+m7ml33GQi5HwQ5Q8Fp?=
 =?us-ascii?Q?1+qKR5BBZmGAPJx9AK/aser43xvjUtNk6+FMmjtPiboUD1ram9ZJj50dk5O7?=
 =?us-ascii?Q?328VchrSw499dYLSSA8TKXr8Zt1I1bqIkQXFyIJ4BcaFW5HFpFEI9UxC5loj?=
 =?us-ascii?Q?TdriE0aUDn50794xqOzA+6O7uc2yOCm/dR2ZpCgqeusGCOP3DmZ8p06ocU8j?=
 =?us-ascii?Q?KEVpXciD2Wmg19TPBepE5sxk02kh2yreK0J5ImhgffG9YySRFky41xuLmE7c?=
 =?us-ascii?Q?8c+LjUkH04kUZKTHN/6oMpK7D8pQ44YbOphesAZP5uWfTrXdOygdd21MFHM4?=
 =?us-ascii?Q?Sf+0pXlSwNqCJ2Wid24upzFxOW67TMEPsr1u2wZddJt8vwJhvJuG6b0l4HGC?=
 =?us-ascii?Q?7CaAmXGuaU77qL1qV/JonmskFEG2lrnDphjeC8PsAsuOipsCuI5jS8n+kExN?=
 =?us-ascii?Q?vHVdR9ac/D/F3NIENNm1JdWnSXElP8fT0ImYh8hkhu2Kwg+jsTjLQJogY50R?=
 =?us-ascii?Q?r118NM1hlsBkTeBUH8c9p/UL8Spy+zt2cLIOZvePCyTMRiuiX1TracElf2Ou?=
 =?us-ascii?Q?m3XdE1kmrvRffnLOXIqYeX9o7hSG+ay0Ct/sjZUbGnrSNXcWN/S2TthJp+Gj?=
 =?us-ascii?Q?0QGzRPV0hfJlTUqWF9GmMNu/+5+rVrs3XO15fquejtt71GnPvkugzPGSpC1n?=
 =?us-ascii?Q?tfk70/rsDXw878YDXoH74J4JtGDdOezh0GWFCZR9X0WdRWuUTQLqx5nPW5wd?=
 =?us-ascii?Q?BHnMV9LgqoB8AlICpizOQZ0h19dwNRmzwCGcPjdVdMLJ6u76y5qGgoefzcZg?=
 =?us-ascii?Q?JhYLaC/63XvKvTG8RZ5tnwCI1oM6Slwdfp2Cnv2rIRJ74zgT2O4a2oOf/mxX?=
 =?us-ascii?Q?L34a8f5QrzR0aEkiIqdinUFWA17Y/pbRYcXU6CEFBb5zO++3NekMxRb7pxTl?=
 =?us-ascii?Q?uX0ZF5u16FsD48WleP2YLH/humJMTrS/kDUwLO4+tDT1l24GBFMfaoFSiUND?=
 =?us-ascii?Q?WDeA9YfXSBjAtarsBTEvB4uEqvkHX0xixGmi4Y8EhUH9gH18JIP2RpUmIXMi?=
 =?us-ascii?Q?YsfweVk3C5/Kr1hD0RFiuPMZFEblPlaR2tcx9dC/xvDpRF6EDWXwZeroFhYb?=
 =?us-ascii?Q?btmHBGBN0WDX0bMo3J35ZJqi3FNB1VBIt0px9LAOQEo3Xp08d/1Qa+Ws+1Vo?=
 =?us-ascii?Q?7Qzt7Qi3fkg0LwgPsuHJ8ygn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5069.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152d92d6-9a14-4912-1653-08d96d6c3fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 17:16:34.4824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsIgbOvpCujQ1Gya66Mvgr2fKCAnrlC0o+kLE5sqFk6GBY0bc31E6TFw9x8RbkyYVb3NB68+nXoGIfQDSplTDbKNPR2N/8RPioaU/u2rVUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3767
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

(dropping all external emails)

Hey, going external was pretty premature here. We do have a process of inte=
rnal review required for any patches that touch x86 subsystem that requires=
 getting signed off by x86 reviewers - with a major revision such as this y=
ou should have waited until one of the x86 reviewers gave you a reviewed by=
 before going external. I appreciate that this is an own time kind of proje=
ct for you, but the community just sees one intel and we all need to follow=
 the same standards and practices. Please read the process.=20

 https://intelpedia.intel.com/Intel_Patch_Review_Process#Review_Process_for=
_x86_submissions

-----Original Message-----
From: Lobakin, Alexandr <alexandr.lobakin@intel.com>=20
Sent: Tuesday, August 31, 2021 7:41 AM
To: linux-hardening@vger.kernel.org
Cc: Accardi, Kristen C <kristen.c.accardi@intel.com>; Kristen Carlson Accar=
di <kristen@linux.intel.com>; Kees Cook <keescook@chromium.org>; Masahiro Y=
amada <masahiroy@kernel.org>; H. Peter Anvin <hpa@zytor.com>; Jessica Yu <j=
eyu@kernel.org>; Nathan Chancellor <nathan@kernel.org>; Nick Desaulniers <n=
desaulniers@google.com>; Marios Pomonis <pomonis@google.com>; Sami Tolvanen=
 <samitolvanen@google.com>; Luck, Tony <tony.luck@intel.com>; Ard Biesheuve=
l <ardb@kernel.org>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; Czapni=
k, Lukasz <lukasz.czapnik@intel.com>; Plantykow, Marta A <marta.a.plantykow=
@intel.com>; Kubiak, Michal <michal.kubiak@intel.com>; Swiatkowski, Michal =
<michal.swiatkowski@intel.com>; Lobakin, Alexandr <alexandr.lobakin@intel.c=
om>; linux-kbuild@vger.kernel.org; linux-arch@vger.kernel.org; linux-kernel=
@vger.kernel.org; clang-built-linux@googlegroups.com
Subject: [PATCH v6 kspp-next 00/22] Function Granular KASLR

This is a massive rework and a respin of Kristen Accardi's marvellous FG-KA=
SLR series (v5).

The major differences since v5 [0]:
* You can now tune the number of functions per each section to
  achieve the preferable vmlinux size or protection level. Default
  is still as one section per each function.
  This can be handy for storage-constrained systems. 4-8 fps are
  still strong, but reduce the size of the final vmlinu{x,z}
  significantly;
* I don't use orphan sections anymore. It's not reliable at all /
  may differ from linker to linker, and also conflicts with
  CONFIG_LD_ORPHAN_WARN which is great for catching random bugs ->
* All the .text.* sections are now being described explicitly in the
  linker script. A Perl script is used to take the original LDS, the
  original object file, read a list of input sections from it and
  generate the resulting LDS.
  This costs a bit of linking time as LD tends to think hard when
  processing scripts > 1 Mb. It adds about 40-60 seconds to the
  whole linking process (BTF step, 2-3 kallsyms steps and the final
  step), but "better safe than sorry".
  In addition, that approach allows to reserve some space at the end
  and add some link assertions ->
* Input .text section now must be empty, otherwise the linkage will
  be stopped. This is implemented by the size assertion in the
  resulting LD script and is designed to plug the potentional layout
  leakage. This also means that ->
* "Regular" ASM functions are now being placed into unique separate
  functions the same way compiler does this for C functions. This is
  achieved by introducing and using several new macros which take
  the symbol name as a base for its new section name.
  This gives a better opportunity to both DCE and FG-KASLR, as ASM
  code now can also be randomized or garbage-collected;
* It's now fully compatible with ClangLTO, ClangCFI,
  CONFIG_LD_ORPHAN_WARN and some more stuff landed since the last
  revision was published;
* Includes several fixes: relocations inside .altinstr_replacement
  code and minor issues found and/or suggested by LKP robot.

The series was compile-time and runtime tested on the following setups with=
 no issues:
- x86_64, GCC 11, Binutils 2.35;
- x86_64, Clang/LLVM 12, ClangLTO + ClangCFI (from Sami's tree).

The first 4 patches are from the linux-kbuild tree and included to avoid me=
rge conflicts and non-intuitive resolving of them.

The series is also available here: [1]

[0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen=
@linux.intel.com
[1] https://github.com/alobakin/linux/pull/3

The original v5 cover letter:

Function Granular Kernel Address Space Layout Randomization (fgkaslr)
---------------------------------------------------------------------

This patch set is an implementation of finer grained kernel address space r=
andomization. It rearranges your kernel code at load time on a per-function=
 level granularity, with only around a second added to boot time.

Changes in v5:
--------------
* fixed a bug in the code which increases boot heap size for
  CONFIG_FG_KASLR which prevented the boot heap from being increased
  for CONFIG_FG_KASLR when using bzip2 compression. Thanks to Andy Lavr
  for finding the problem and identifying the solution.
* changed the adjustment of the orc_unwind_ip table at boot time to
  disregard relocs associated with this table, and instead inspect the
  entries separately. Relocs are not able to be used since they are
  no longer correct once the table is resorted at buildtime.
* changed how orc_unwind_ip addresses in randomized sections are identified
  to include the byte immediately after the end of the section.
* updated module code to use kvmalloc/kvfree based on suggestions from
  Evgenii Shatokhin <eshatokhin@virtuozzo.com>.
* changed kernel commandline to disable fgkaslr to simply "nofgkaslr" to
  match the nokaslr option. fgkaslr=3D"X" can be added at a later date
  if it is needed.
* Added a patch to force livepatch to require symbols to be unique if
  using while fgkaslr either for core or modules.

Changes in v4:
-------------
* dropped the patch to split out change to STATIC definition in
  x86/boot/compressed/misc.c and replaced with a patch authored
  by Kees Cook to avoid the duplicate malloc definitions
* Added a section to Documentation/admin-guide/kernel-parameters.txt
  to document the fgkaslr boot option.
* redesigned the patch to hide the new layout when reading
  /proc/kallsyms. The previous implementation utilized a dynamically
  allocated linked list to display the kernel and module symbols
  in alphabetical order. The new implementation uses a randomly
  shuffled index array to display the kernel and module symbols
  in a random order.

Changes in v3:
-------------
* Makefile changes to accommodate CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
* removal of extraneous ALIGN_PAGE from _etext changes
* changed variable names in x86/tools/relocs to be less confusing
* split out change to STATIC definition in x86/boot/compressed/misc.c
* Updates to Documentation to make it more clear what is preserved in .text
* much more detailed commit message for function granular KASLR patch
* minor tweaks and changes that make for more readable code
* this cover letter updated slightly to add additional details

Changes in v2:
--------------
* Fix to address i386 build failure
* Allow module reordering patch to be configured separately so that
  arm (or other non-x86_64 arches) can take advantage of module function
  reordering. This support has not be tested by me, but smoke tested by
  Ard Biesheuvel <ardb@kernel.org> on arm.
* Fix build issue when building on arm as reported by
  Ard Biesheuvel <ardb@kernel.org>=20

Patches to objtool are included because they are dependencies for this patc=
hset, however they have been submitted by their maintainer separately.

Background
----------
KASLR was merged into the kernel with the objective of increasing the diffi=
culty of code reuse attacks. Code reuse attacks reused existing code snippe=
ts to get around existing memory protections. They exploit software bugs wh=
ich expose addresses of useful code snippets to control the flow of executi=
on for their own nefarious purposes. KASLR moves the entire kernel code tex=
t as a unit at boot time in order to make addresses less predictable.
The order of the code within the segment is unchanged - only the base addre=
ss is shifted. There are a few shortcomings to this algorithm.

1. Low Entropy - there are only so many locations the kernel can fit in. Th=
is
   means an attacker could guess without too much trouble.
2. Knowledge of a single address can reveal the offset of the base address,
   exposing all other locations for a published/known kernel image.
3. Info leaks abound.

Finer grained ASLR has been proposed as a way to make ASLR more resistant t=
o info leaks. It is not a new concept at all, and there are many variations=
 possible. Function reordering is an implementation of finer grained ASLR w=
hich randomizes the layout of an address space on a function level granular=
ity. We use the term "fgkaslr" in this document to refer to the technique o=
f function reordering when used with KASLR, as well as finer grained KASLR =
in general.

Proposed Improvement
--------------------
This patch set proposes adding function reordering on top of the existing K=
ASLR base address randomization. The over-arching objective is incremental =
improvement over what we already have. It is designed to work in combinatio=
n with the existing solution. The implementation is really pretty simple, a=
nd there are 2 main area where changes occur:

* Build time

GCC has had an option to place functions into individual .text sections for=
 many years now. This option can be used to implement function reordering a=
t load time. The final compiled vmlinux retains all the section headers, wh=
ich can be used to help find the address ranges of each function. Using thi=
s information and an expanded table of relocation addresses, individual tex=
t sections can be suffled immediately after decompression. Some data tables=
 inside the kernel that have assumptions about order require re-sorting aft=
er being updated when applying relocations. In order to modify these tables=
, a few key symbols are excluded from the objcopy symbol stripping process =
for use after shuffling the text segments.

Some highlights from the build time changes to look for:

The top level kernel Makefile was modified to add the gcc flag if it is sup=
ported. Currently, I am applying this flag to everything it is possible to =
randomize. Anything that is written in C and not present in a special input=
 section is randomized. The final binary segment 0 retains a consolidated .=
text section, as well as all the individual .text.* sections.
Future work could turn off this flags for selected files or even entire sub=
systems, although obviously at the cost of security.

The relocs tool is updated to add relative relocations. This information pr=
eviously wasn't included because it wasn't necessary when moving the entire=
 .text segment as a unit.=20

A new file was created to contain a list of symbols that objcopy should kee=
p. We use those symbols at load time as described below.

* Load time

The boot kernel was modified to parse the vmlinux elf file after decompress=
ion to check for our interesting symbols that we kept, and to look for any =
.text.* sections to randomize. The consolidated .text section is skipped an=
d not moved. The sections are shuffled randomly, and copied into memory fol=
lowing the .text section in a new random order. The existing code which upd=
ated relocation addresses was modified to account for not just a fixed delt=
a from the load address, but the offset that the function section was moved=
 to. This requires inspection of each address to see if it was impacted by =
a randomization. We use a bsearch to make this less horrible on performance=
. Any tables that need to be modified with new addresses or resorted are up=
dated using the symbol addresses parsed from the elf symbol table.

In order to hide our new layout, symbols reported through /proc/kallsyms wi=
ll be displayed in a random order.

Security Considerations
-----------------------
The objective of this patch set is to improve a technology that is already =
merged into the kernel (KASLR). This code will not prevent all attacks, but=
 should instead be considered as one of several tools that can be used.
In particular, this code is meant to make KASLR more effective in the prese=
nce of info leaks.

How much entropy we are adding to the existing entropy of standard KASLR wi=
ll depend on a few variables. Firstly and most obviously, the number of fun=
ctions that are randomized matters. This implementation keeps the existing =
.text section for code that cannot be randomized - for example, because it =
was assembly code. The less sections to randomize, the less entropy. In add=
ition, due to alignment (16 bytes for x86_64), the number of bits in a addr=
ess that the attacker needs to guess is reduced, as the lower bits are iden=
tical.

Performance Impact
------------------
There are two areas where function reordering can impact performance: boot =
time latency, and run time performance.

* Boot time latency
This implementation of finer grained KASLR impacts the boot time of the ker=
nel in several places. It requires additional parsing of the kernel ELF fil=
e to obtain the section headers of the sections to be randomized. It calls =
the random number generator for each section to be randomized to determine =
that section's new memory location. It copies the decompressed kernel into =
a new area of memory to avoid corruption when laying out the newly randomiz=
ed sections. It increases the number of relocations the kernel has to perfo=
rm at boot time vs. standard KASLR, and it also requires a lookup on each a=
ddress that needs to be relocated to see if it was in a randomized section =
and needs to be adjusted by a new offset. Finally, it re-sorts a few data t=
ables that are required to be sorted by address.

Booting a test VM on a modern, well appointed system showed an increase in =
latency of approximately 1 second.

* Run time
The performance impact at run-time of function reordering varies by workloa=
d.
Using kcbench, a kernel compilation benchmark, the performance of a kernel =
build with finer grained KASLR was about 1% slower than a kernel with stand=
ard KASLR. Analysis with perf showed a slightly higher percentage of L1-ica=
che-load-misses. Other workloads were examined as well, with varied results=
. Some workloads performed significantly worse under FGKASLR, while others =
stayed the same or were mysteriously better. In general, it will depend on =
the code flow whether or not finer grained KASLR will impact your workload,=
 and how the underlying code was designed. Because the layout changes per b=
oot, each time a system is rebooted the performance of a workload may chang=
e.

Future work could identify hot areas that may not be randomized and either =
leave them in the .text section or group them together into a single sectio=
n that may be randomized. If grouping things together helps, one other thin=
g to consider is that if we could identify text blobs that should be groupe=
d together to benefit a particular code flow, it could be interesting to ex=
plore whether this security feature could be also be used as a performance =
feature if you are interested in optimizing your kernel layout for a partic=
ular workload at boot time. Optimizing function layout for a particular wor=
kload has been researched and proven effective - for more information read =
the Facebook paper "Optimizing Function Placement for Large-Scale Data-Cent=
er Applications" (see references section below).

Image Size
----------
Adding additional section headers as a result of compiling with -ffunction-=
sections will increase the size of the vmlinux ELF file.
With a standard distro config, the resulting vmlinux was increased by about=
 3%. The compressed image is also increased due to the header files, as wel=
l as the extra relocations that must be added. You can expect fgkaslr to in=
crease the size of the compressed image by about 15%.

Memory Usage
------------
fgkaslr increases the amount of heap that is required at boot time, althoug=
h this extra memory is released when the kernel has finished decompression.=
 As a result, it may not be appropriate to use this feature on systems with=
out much memory.

Building
--------
To enable fine grained KASLR, you need to have the following config options=
 set (including all the ones you would use to build normal KASLR)

CONFIG_FG_KASLR=3Dy

In addition, fgkaslr is only supported for the X86_64 architecture.

Modules
-------
Modules are randomized similarly to the rest of the kernel by shuffling the=
 sections at load time prior to moving them into memory. The module must al=
so have been build with the -ffunction-sections compiler option.

Although fgkaslr for the kernel is only supported for the X86_64 architectu=
re, it is possible to use fgkaslr with modules on other architectures. To e=
nable this feature, select

CONFIG_MODULE_FG_KASLR=3Dy

This option is selected automatically for X86_64 when CONFIG_FG_KASLR is se=
t.

Disabling
---------
Disabling normal KASLR using the nokaslr command line option also disables =
fgkaslr. It is also possible to disable fgkaslr separately by booting with =
nofgkaslr on the commandline.

References
----------
There are a lot of academic papers which explore finer grained ASLR.
This paper in particular contributed the most to my implementation design a=
s well as my overall understanding of the problem space:

Selfrando: Securing the Tor Browser against De-anonymization Exploits, M. C=
onti, S. Crane, T. Frassetto, et al.

For more information on how function layout impacts performance, see:

Optimizing Function Placement for Large-Scale Data-Center Applications, G. =
Ottoni, B. Maher

Alexander Lobakin (7):
  linkage: add macros for putting ASM functions into own sections
  x86: conditionally place regular ASM functions into separate sections
  FG-KASLR: use a scripted approach to handle .text.* sections
  x86/boot: allow FG-KASLR to be selected
  arm64/crypto: conditionally place ASM functions into separate sections
  module: use a scripted approach for FG-KASLR
  maintainers: add MAINTAINERS entry for FG-KASLR

Kees Cook (2):
  x86/boot: Allow a "silent" kaslr random byte fetch
  x86/boot/compressed: Avoid duplicate malloc() implementations

Kristen Carlson Accardi (9):
  x86: tools/relocs: Support >64K section headers
  x86: Makefile: Add build and config option for CONFIG_FG_KASLR
  Make sure ORC lookup covers the entire _etext - _stext
  x86/tools: Add relative relocs for randomized functions
  x86: Add support for function granular KASLR
  kallsyms: Hide layout
  livepatch: only match unique symbols when using fgkaslr
  module: Reorder functions
  Documentation: add a documentation for FG-KASLR

Masahiro Yamada (3):
  kbuild: merge vmlinux_link() between the ordinary link and Clang LTO
  kbuild: do not remove 'linux' link in scripts/link-vmlinux.sh
  kbuild: merge vmlinux_link() between ARCH=3Dum and other architectures

Sami Tolvanen (1):
  kbuild: Fix TRIM_UNUSED_KSYMS with LTO_CLANG

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/security/fgkaslr.rst            | 172 ++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |  12 +
 Makefile                                      |  17 +-
 arch/Kconfig                                  |   3 +
 arch/arm64/crypto/aes-ce-ccm-core.S           |  16 +-
 arch/arm64/crypto/aes-ce-core.S               |  16 +-
 arch/arm64/crypto/aes-ce.S                    |   4 +-
 arch/arm64/crypto/aes-cipher-core.S           |   8 +-
 arch/arm64/crypto/aes-modes.S                 |  16 +-
 arch/arm64/crypto/aes-neon.S                  |   4 +-
 arch/arm64/crypto/aes-neonbs-core.S           |  38 +-
 arch/arm64/crypto/chacha-neon-core.S          |  18 +-
 arch/arm64/crypto/crct10dif-ce-core.S         |  14 +-
 arch/arm64/crypto/ghash-ce-core.S             |  24 +-
 arch/arm64/crypto/nh-neon-core.S              |   4 +-
 arch/arm64/crypto/poly1305-armv8.pl           |  17 +
 arch/arm64/crypto/sha1-ce-core.S              |   4 +-
 arch/arm64/crypto/sha2-ce-core.S              |   4 +-
 arch/arm64/crypto/sha3-ce-core.S              |   4 +-
 arch/arm64/crypto/sha512-armv8.pl             |  11 +
 arch/arm64/crypto/sha512-ce-core.S            |   4 +-
 arch/arm64/crypto/sm3-ce-core.S               |   4 +-
 arch/arm64/crypto/sm4-ce-core.S               |   4 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/boot/compressed/Makefile             |   9 +-
 arch/x86/boot/compressed/fgkaslr.c            | 905 ++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c              |   4 -
 arch/x86/boot/compressed/misc.c               | 157 ++-
 arch/x86/boot/compressed/misc.h               |  30 +
 arch/x86/boot/compressed/utils.c              |  13 +
 arch/x86/boot/compressed/vmlinux.symbols      |  19 +
 arch/x86/crypto/aegis128-aesni-asm.S          |  36 +-
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S       |  12 +-
 arch/x86/crypto/aesni-intel_asm.S             | 116 ++-
 arch/x86/crypto/aesni-intel_avx-x86_64.S      |  32 +-
 arch/x86/crypto/blake2s-core.S                |   8 +-
 arch/x86/crypto/blowfish-x86_64-asm_64.S      |  16 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S   |  28 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S  |  28 +-
 arch/x86/crypto/camellia-x86_64-asm_64.S      |  16 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S     |  24 +-
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S     |  20 +-
 arch/x86/crypto/chacha-avx2-x86_64.S          |  12 +-
 arch/x86/crypto/chacha-avx512vl-x86_64.S      |  12 +-
 arch/x86/crypto/chacha-ssse3-x86_64.S         |  16 +-
 arch/x86/crypto/crc32-pclmul_asm.S            |   4 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S     |   4 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S        |   4 +-
 arch/x86/crypto/des3_ede-asm_64.S             |   8 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S     |  12 +-
 arch/x86/crypto/nh-avx2-x86_64.S              |   4 +-
 arch/x86/crypto/nh-sse2-x86_64.S              |   4 +-
 arch/x86/crypto/poly1305-x86_64-cryptogams.pl |   8 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S   |  20 +-
 arch/x86/crypto/serpent-avx2-asm_64.S         |  20 +-
 arch/x86/crypto/serpent-sse2-i586-asm_32.S    |   8 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S  |   8 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S        |   4 +-
 arch/x86/crypto/sha1_ni_asm.S                 |   4 +-
 arch/x86/crypto/sha1_ssse3_asm.S              |   4 +-
 arch/x86/crypto/sha256-avx-asm.S              |   4 +-
 arch/x86/crypto/sha256-avx2-asm.S             |   4 +-
 arch/x86/crypto/sha256-ssse3-asm.S            |   4 +-
 arch/x86/crypto/sha256_ni_asm.S               |   4 +-
 arch/x86/crypto/sha512-avx-asm.S              |   4 +-
 arch/x86/crypto/sha512-avx2-asm.S             |   4 +-
 arch/x86/crypto/sha512-ssse3-asm.S            |   4 +-
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S   |  20 +-
 arch/x86/crypto/twofish-i586-asm_32.S         |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S  |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S       |   8 +-
 arch/x86/entry/entry_32.S                     |  24 +-
 arch/x86/entry/entry_64.S                     |  18 +-
 arch/x86/entry/thunk_32.S                     |   4 +-
 arch/x86/entry/thunk_64.S                     |   8 +-
 arch/x86/include/asm/boot.h                   |  13 +-
 arch/x86/include/asm/paravirt.h               |   2 +-
 arch/x86/include/asm/qspinlock_paravirt.h     |   2 +-
 arch/x86/kernel/acpi/wakeup_32.S              |   9 +-
 arch/x86/kernel/acpi/wakeup_64.S              |  10 +-
 arch/x86/kernel/ftrace_32.S                   |  19 +-
 arch/x86/kernel/ftrace_64.S                   |  28 +-
 arch/x86/kernel/irqflags.S                    |   4 +-
 arch/x86/kernel/kprobes/core.c                |   3 +-
 arch/x86/kernel/kvm.c                         |   2 +-
 arch/x86/kernel/relocate_kernel_32.S          |   2 +
 arch/x86/kernel/relocate_kernel_64.S          |   2 +
 arch/x86/kernel/vmlinux.lds.S                 |   6 +-
 arch/x86/kvm/emulate.c                        |   2 +-
 arch/x86/kvm/vmx/vmenter.S                    |   8 +-
 arch/x86/lib/clear_page_64.S                  |  12 +-
 arch/x86/lib/cmpxchg16b_emu.S                 |   4 +-
 arch/x86/lib/copy_mc_64.S                     |   8 +-
 arch/x86/lib/copy_page_64.S                   |   7 +-
 arch/x86/lib/copy_user_64.S                   |  18 +-
 arch/x86/lib/csum-copy_64.S                   |   4 +-
 arch/x86/lib/error-inject.c                   |   3 +-
 arch/x86/lib/getuser.S                        |  37 +-
 arch/x86/lib/hweight.S                        |   9 +-
 arch/x86/lib/iomap_copy_64.S                  |   4 +-
 arch/x86/lib/kaslr.c                          |  18 +-
 arch/x86/lib/memmove_64.S                     |   4 +-
 arch/x86/lib/memset_64.S                      |  12 +-
 arch/x86/lib/msr-reg.S                        |   8 +-
 arch/x86/lib/putuser.S                        |  18 +-
 arch/x86/mm/mem_encrypt_boot.S                |   8 +-
 arch/x86/platform/efi/efi_stub_64.S           |   4 +-
 arch/x86/platform/efi/efi_thunk_64.S          |   4 +-
 arch/x86/power/hibernate_asm_32.S             |  14 +-
 arch/x86/power/hibernate_asm_64.S             |  14 +-
 arch/x86/tools/relocs.c                       | 135 ++-
 arch/x86/tools/relocs.h                       |   4 +-
 arch/x86/tools/relocs_common.c                |  15 +-
 arch/x86/xen/xen-asm.S                        |  49 +-
 arch/x86/xen/xen-head.S                       |  10 +-
 include/asm-generic/vmlinux.lds.h             |  41 +-
 include/linux/decompress/mm.h                 |  12 +-
 include/linux/linkage.h                       |  76 ++
 include/uapi/linux/elf.h                      |   1 +
 init/Kconfig                                  |  51 +
 kernel/kallsyms.c                             | 158 ++-
 kernel/livepatch/core.c                       |  11 +
 kernel/module.c                               |  91 +-
 scripts/Makefile.build                        |  27 +-
 scripts/Makefile.lib                          |   7 +
 scripts/Makefile.modfinal                     |  36 +-
 scripts/Makefile.modpost                      |  22 +-
 scripts/gen_autoksyms.sh                      |  12 -
 scripts/generate_text_sections.pl             | 149 +++
 scripts/link-vmlinux.sh                       | 104 +-
 scripts/module.lds.S                          |  14 +-
 133 files changed, 2771 insertions(+), 757 deletions(-)  create mode 10064=
4 Documentation/security/fgkaslr.rst
 create mode 100644 arch/x86/boot/compressed/fgkaslr.c
 create mode 100644 arch/x86/boot/compressed/utils.c  create mode 100644 ar=
ch/x86/boot/compressed/vmlinux.symbols
 create mode 100755 scripts/generate_text_sections.pl

--
2.31.1

